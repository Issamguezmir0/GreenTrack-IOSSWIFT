import Foundation

struct CheckRequest: Encodable {
    let num_tel: String
    let resetCode: String
    
}

class CheckViewModel: ObservableObject {
    
    @Published var num_tel: String = ""
    @Published var resetCode: String = ""

    func send() {
        let apiUrl = URL(string: "http://localhost:3002/password/verify-code")!
        
        let requestBody = CheckRequest(num_tel: num_tel,resetCode: resetCode)
        
        do {
            let jsonData = try JSONEncoder().encode(requestBody)
            print("Request JSON Data: \(String(data: jsonData, encoding: .utf8) ?? "Invalid JSON")")

            var request = URLRequest(url: apiUrl)
            request.httpMethod = "POST"
            request.httpBody = jsonData
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                } else if let data = data {
                    do {
                        if let jsonString = String(data: data, encoding: .utf8) {
                            print("Raw Response Data: \(jsonString)")
                        }
                        
                        if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                            if let message = jsonResponse["message"] as? String {
                                print("Response Message: \(message)")
                                // Handle the message as needed
                            } else {
                                print("Invalid or missing 'message' key in the response.")
                            }
                        } else if let errorString = String(data: data, encoding: .utf8) {
                            print("Error Response: \(errorString)")
                            // Handle the error response as needed
                        } else {
                            print("Invalid or unexpected response format.")
                        }
                    } catch {
                        print("Error parsing JSON: \(error.localizedDescription)")
                    }
                }
            }.resume()
        } catch {
            print("Error encoding JSON: \(error.localizedDescription)")
        }
    }
}
