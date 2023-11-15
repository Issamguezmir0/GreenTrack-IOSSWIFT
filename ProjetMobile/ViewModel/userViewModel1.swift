//
//  userViewModel1.swift
//  ProjetMobile
//
//  Created by issam guezmir on 13/11/2023.
//

import SwiftUI

class userViewModel1: ObservableObject {
    
    /* @Published var fullname = ""
     @Published var password = ""
     @Published var password1 = ""
     @Published var email = ""
     @Published var registrationStatus: registrationStatus?
     
     enum registrationStatus {
     case idle, registering, success(User), failure(Error)
     }
     
     func signup() {
     DispatchQueue.main.async {
     self.registrationStatus = .registering
     APIManager.shared.signup(fullname: self.fullname, password: self.password, email: self.email) { (result: Result<User, Error>) in
     switch result {
     case .success(let user):
     DispatchQueue.main.async {
     self.registrationStatus = .success(user)
     }
     case .failure(let error):
     DispatchQueue.main.async {
     self.registrationStatus = .failure(error)
     }
     }
     }
     }
     }*/
    @Published var fullname: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    
    // Function to send signup request
    
    func signup() {
        
        
        // Create a JSON body
        //let dateOfBirthJSON: String = dateofbirth.formatted(.iso8601)
        let requestBody: [String: Any] = [
            "fullname": fullname,
            "email": email,
            "password": password,
            
            // ... include other properties
        ]
        
        // Convert the request body to Data
        if let jsonData = try? JSONSerialization.data(withJSONObject: requestBody) {
            // Perform the API request (you'll need to implement this)
            APIManager.shared.signup(data: jsonData) { result in
                // Handle the result (success or failure)
                switch result {
                case .success:
                    //self.signedUp = true
                    // Handle successful signup
                    //self.signupError = "Signup Success"
                    print("Signup successful")
                case .failure(let error):
                    // Handle signup failure
                    //self.signupError = "Signup failed: \(error.localizedDescription)"
                    print("Signup failed: \(error.localizedDescription)")
                }
                
            }
        }
    }
    
    func login() {
        
        // Create a JSON body with the user's credentials
        let apiUrl = URL(string: "http://localhost:3000/auth/signin")!
        
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
                        // You can update your UI or perform other actions based on the response
                    } catch {
                        print("Error parsing JSON: \(error.localizedDescription)")
                    }
                }
                
            }.resume()
            
        } catch {
            print("error taa do")
        }
        
    }}
