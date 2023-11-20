//
//  EditProfileViewModel.swift
//  ProjetMobile
//
//  Created by issam guezmir on 20/11/2023.
//

import Foundation

class EditProfileViewModel: ObservableObject {
    /*@Published var user: UserModifyModel
     @Published var isLoading = false
     @Published var error: Error?*/
    
    
    @Published var email: String = ""
    @Published var fullname: String = ""
    @Published var num_tel: String = ""
    
    
    @Published var isNavigationActive: Bool = false
    func fillUserFromUserDefaults() {
        guard let userId = UserDefaults.standard.string(forKey: "userId") else {
            return print("Error getting user ID from UserDefaults")
        }
        
        self.email = UserDefaults.standard.string(forKey: "userEmail") ?? ""
        self.fullname = UserDefaults.standard.string(forKey: "userFullname") ?? ""
        self.num_tel = UserDefaults.standard.string(forKey: "userNum_tel") ?? ""
        
    }
    init() {
        // ... (other setup)
        fillUserFromUserDefaults()
        
    }
    func updateUser() {
       
        //UserDefaults.standard.set(id, forKey: "userId")
        guard let userId = UserDefaults.standard.string(forKey: "userId") else {
            return print("Error getting user ID from UserDefaults")
        }
        print(userId)
        // Validate user input before sending the update request
        let apiUrl = URL(string: "http://localhost:3002/auth/edit-profile/\(userId)")!
        //let dateOfBirthJSON: String = dateofbirth.formatted(.iso8601)
        let requestBody: [String: Any] = [
            "id": userId,
            "fullname": fullname,
            "email": email,// Include role in the JSON body
            "num_tel": num_tel
        ]
        
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: requestBody)
            var request = URLRequest(url: apiUrl)
            
            // Set the request method to POST
            request.httpMethod = "PUT"
            
            // Set the request body with the JSON data
            request.httpBody = jsonData
            
            // Set the request header to indicate JSON content
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                // Handle the response and error here
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                } else if let data {
                    
                    do {
                        
                        print("Fullname: \(self.fullname)")
                        UserDefaults.standard.set(self.fullname, forKey: "userFullname")
                        
                        print("Email: \(self.email)")
                        UserDefaults.standard.set(self.email, forKey: "userEmail")
                        
                        print("Num_tel: \(self.num_tel)")
                        UserDefaults.standard.set(self.num_tel, forKey: "userNum_tel")
                        
                        
                        
                        
                        
                        // You can update your UI or perform other actions based on the response
                    } catch {
                        print("Error parsing JSON: \(error.localizedDescription)")
                    }
                }
               
            }.resume()
            
        } catch {
            print("error taa do")
        }
        
        // Simulate loading
        
        
        
        
        
        
        
        
    }
}
