import Foundation

struct RequestChange: Encodable {
    let userId: String
    let currentPassword: String
    let newPassword: String
    
}

class ChangePassViewModel: ObservableObject {
    
    @Published var userId: String = ""
    @Published var currentPassword: String = ""
    @Published var newPassword: String = ""
    
    init() {
       
        fillUserFromUserDefaults()
    }
    
    func fillUserFromUserDefaults() {
        guard let id = UserDefaults.standard.string(forKey: "userId") else {
            print("Erreur lors de la récupération de l'ID utilisateur depuis UserDefaults")
            return
        }
        
        self.userId = id
        
    }

    func send() {
        let apiUrl = URL(string: "http://localhost:3002/password/change-password")!
        
        let requestBody = RequestChange(userId: userId,currentPassword: currentPassword,newPassword: newPassword)
        
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
