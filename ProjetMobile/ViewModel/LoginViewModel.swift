//
//  LoginViewModel.swift
//  ProjetMobile
//
//  Created by issam guezmir on 15/11/2023.
//

import Foundation

class LoginViewModel: ObservableObject {
    
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isNavigationActive: Bool = false
    func login() {
        // Assume you retrieve the token after a successful login
                let retrievedToken = "your_retrieved_token_value"
        let retrievedId = "your_retrieved_id_value"

                // Store the token in UserDefaults
                UserDefaults.standard.set(retrievedToken, forKey: "token")
        UserDefaults.standard.set(retrievedId, forKey: "id")



                // Assign the token to the published variable for other view models to observe
                //token = retrievedToken
        DispatchQueue.main.async {
                   //// Show loading view
                         }
        // Create a JSON body with the user's credentials
        let apiUrl = URL(string: "http://localhost:3002/auth/signin")!
        
        let requestBody: [String: Any] = [
            "email": email,
            "password": password,
        ]
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: requestBody)
            var request = URLRequest(url: apiUrl)
            
            // Set the request method to POST
            request.httpMethod = "POST"
            
            // Set the request body with the JSON data
            request.httpBody = jsonData
            
            // Set the request header to indicate JSON content
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                // Handle the response and error here
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                } else if let data = data {
                    // Parse and handle the response data
                    // Note: You should handle this according to your API response format
                    do {
                        let jsonResponse = try JSONSerialization.jsonObject(with: data, options: [])
                        print("Response: \(jsonResponse)")
                        if let jsonDictionary = jsonResponse as? [String: Any], let token = jsonDictionary["token"] as? String {
                                                    print("Token: \(token)")
                                                    // Save the token to your session or any storage mechanism you prefer
                                                    // Example using UserDefaults:
                                                    UserDefaults.standard.set(token, forKey: "accessToken")
                                                   
                                                }
                        // You can update your UI or perform other actions based on the response
                    } catch {
                        print("Error parsing JSON: \(error.localizedDescription)")
                    }
                }
                DispatchQueue.main.async {
                                   // self.isLoading = false
                                    self.isNavigationActive = true
                                }
            }.resume()
            
        } catch {
            print("error taa do")
        }
    }
}
