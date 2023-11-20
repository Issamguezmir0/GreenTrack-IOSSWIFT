//
//  ProfileViewModel.swift
//  ProjetMobile
//
//  Created by issam guezmir on 20/11/2023.
//

import Foundation

class ProfileViewModel: ObservableObject {
    @Published var user: User?
    @Published var isLoading = false
    @Published var error: Error?
    
    @Published var email: String = ""
    @Published var fullname: String = ""
    @Published var num_tel: String = ""
    @Published var img: String = ""
    @Published var isNavigationActive: Bool = false
    private let apiManager = APIManager.shared
    func fillUserFromUserDefaults() {
        DispatchQueue.main.async {
            self.isLoading = true // Show loading view
                 }
            guard let userId = UserDefaults.standard.string(forKey: "userId") else {
                return print("Error getting user ID from UserDefaults")
            }

            self.email = UserDefaults.standard.string(forKey: "userEmail") ?? ""
        self.num_tel = UserDefaults.standard.string(forKey: "userPhone") ?? ""
            self.fullname = UserDefaults.standard.string(forKey: "userFullName") ?? ""
        }
    init() {
        // ... (other setup)
        fillUserFromUserDefaults()
        authenticateUserProfile()
    }
    func authenticateUserProfile() {
        //isLoading = true
        guard let token = UserDefaults.standard.string(forKey: "accessToken") else {
            return print("error getting the token")
        }
        print("test")
        print(token)
        
        let apiUrl = URL(string: "http://localhost:3002/auth/authentifier-profil")!
        do {
            
            
            var request = URLRequest(url: apiUrl)
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.addValue(token, forHTTPHeaderField: "Authorization")
            
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                } else if let data = data {
                    
                    do {
                        let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                        /*guard let userInfo = jsonResponse else {
                            // Handle the case where jsonResponse is nil
                            print("Failed to parse JSON response")
                            return
                        }*/
                        print(jsonResponse)
                      
                        guard let userInfo = jsonResponse else { return }
                       
                        let id = userInfo["id"] as? String
                        if let id = id {
                            print("ID: \(id)")
                            UserDefaults.standard.set(id, forKey: "userId")
                        } else {
                            print("Failed to retrieve ID from JSON response")
                        }

                        let fullname = userInfo["fullname"] as? String
                        if let fullname = fullname {
                            print("Fullname: \(fullname)")
                            UserDefaults.standard.set(fullname, forKey: "userFullName")
                        } else {
                            print("Failed to retrieve fullname from JSON response")
                        }

                        let email = userInfo["email"] as? String
                        if let email = email {
                            print("Email: \(email)")
                            UserDefaults.standard.set(email, forKey: "userEmail")
                        } else {
                            print("Failed to retrieve email from JSON response")
                        }
                        
                        let img = userInfo["img"] as? String
                        if let img = img {
                            print("Image: \(img)")
                            UserDefaults.standard.set(img, forKey: "userImage")
                        } else {
                            print("Failed to retrieve email from JSON response")
                        }
                        
                        let num_tel = userInfo["phone"] as? String
                        if let num_tel = num_tel {
                            print("phone: \(num_tel)")
                            UserDefaults.standard.set(num_tel, forKey: "userPhone")
                        } else {
                            print("Failed to retrieve email from JSON response")
                        }
                        
                       

                      

                      
                        


                      

                   
                        
                  
                       
                       
                    } catch {
                        print("Error parsing JSON: \(error.localizedDescription)")
                    }
                    
                }
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.isNavigationActive = true
                }
            }.resume()
            
        } catch {
            print("error taa do")
        }
        
        
        
        
        
    }
}
