/*import Foundation
 
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
 
 func authenticateUserProfile() {
 guard let token = UserDefaults.standard.string(forKey: "token") else {
 print("Erreur lors de la récupération du jeton depuis UserDefaults")
 return
 }
 
 let apiUrl = URL(string: "http://localhost:3002/auth/authentifier-profil")!
 
 var request = URLRequest(url: apiUrl)
 request.httpMethod = "GET"
 request.addValue("application/json", forHTTPHeaderField: "Content-Type")
 request.addValue("application/json", forHTTPHeaderField: "Accept")
 request.addValue(token, forHTTPHeaderField: "Authorization")
 
 print("Avant la tâche URLSession")
 
 URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
 guard let self = self else { return }
 
 print("Dans le bloc de URLSession")
 
 if let error = error {
 print("Erreur : \(error.localizedDescription)")
 } else if let data = data {
 do {
 let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
 
 guard let userInfo = jsonResponse else {
 print("Échec de l'analyse de la réponse JSON")
 return
 }
 
 // Extraction des informations de l'utilisateur de la réponse JSON
 if let id = userInfo["userId"] as? String {
 UserDefaults.standard.set(id, forKey: "userId")
 print("ID: \(id)")
 }
 
 if let fullname = userInfo["fullname"] as? String {
 UserDefaults.standard.set(fullname, forKey: "userFullName")
 DispatchQueue.main.async {
 self.fullname = fullname
 }
 print("Nom complet : \(fullname)")
 }
 
 if let email = userInfo["email"] as? String {
 UserDefaults.standard.set(email, forKey: "userEmail")
 DispatchQueue.main.async {
 self.email = email
 }
 print("E-mail : \(email)")
 }
 
 if let img = userInfo["img"] as? String {
 UserDefaults.standard.set(img, forKey: "userImage")
 print("Image : \(img)")
 }
 
 if let num_tel = userInfo["phone"] as? String {
 UserDefaults.standard.set(num_tel, forKey: "userPhone")
 DispatchQueue.main.async {
 self.num_tel = num_tel
 }
 print("Numéro de téléphone : \(num_tel)")
 }
 
 } catch {
 print("Erreur d'analyse JSON : \(error.localizedDescription)")
 }
 }
 
 print("Après la tâche URLSession")
 
 DispatchQueue.main.async {
 self.isLoading = false
 self.isNavigationActive = true
 }
 }.resume()
 }
 }*/

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
    
    init() {
        // ... (other setup)
        fillUserFromUserDefaults()
        authenticateUserProfile()
    }
    
    func fillUserFromUserDefaults() {
       
        guard let userId = UserDefaults.standard.string(forKey: "userId") else {
            return print("Erreur lors de la récupération de l'ID utilisateur depuis UserDefaults")
        }
        
        self.email = UserDefaults.standard.string(forKey: "userEmail") ?? ""
        self.num_tel = UserDefaults.standard.string(forKey: "userPhone") ?? ""
        self.fullname = UserDefaults.standard.string(forKey: "userFullName") ?? ""
    }
    
    func authenticateUserProfile() {
        guard let token = UserDefaults.standard.string(forKey: "accessToken") else {
            return print("Erreur lors de la récupération du jeton depuis UserDefaults")
        }
        
        let apiUrl = URL(string: "http://localhost:3002/auth/authentifier-profil")!
        
        var request = URLRequest(url: apiUrl)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue(token, forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
            guard let self = self else { return }
            
            if let error = error {
                print("Erreur : \(error.localizedDescription)")
            } else if let data = data {
                do {
                    let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                    print(jsonResponse)
                    
                    
                    
                    
                    guard let userInfo = jsonResponse else { return }
                    let id = userInfo["id"] as? String
                    if let id = id {
                        print("ID from viewmodel: \(id)")
                        UserDefaults.standard.set(id, forKey: "userId")
                    } else {
                        print("Failed to retrieve ID from JSON response")
                    }
                    
                    
                    
                    
                    let email = userInfo["email"] as? String
                    if let email = email {
                        print("email from viewmodel: \(email)")
                        UserDefaults.standard.set(email, forKey: "useremail")
                    } else {
                        print("Failed to retrieve email from JSON response")
                    }
                    
                    let fullname = userInfo["fullname"] as? String
                    if let fullname = fullname {
                        print("fullname from viewmodel: \(fullname)")
                        UserDefaults.standard.set(fullname, forKey: "userfullname")
                    } else {
                        print("Failed to retrieve email from JSON response")
                    }
                    
                    
                   let num_tel = userInfo["num_tel"] as? String
                    if let num_tel = num_tel {
                        print("num_tel from viewmodel: \(num_tel)")
                        UserDefaults.standard.set(num_tel, forKey: "usernum_tel")
                    } else {
                        print("Failed to retrieve email from JSON response")
                    }
                    
                    
                    
                    /*UserDefaults.standard.set(jsonResponse.idUser, forKey: "userId")
                    UserDefaults.standard.set(jsonResponse.fullname, forKey: "userFullName")
                    UserDefaults.standard.set(jsonResponse.email, forKey: "userEmail")
                    UserDefaults.standard.set(jsonResponse.num_tel, forKey: "userPhone")*/
                    
                    // Ajoutez d'autres enregistrements en fonction de la structure de votre réponse JSON
                    UserDefaults.standard.synchronize()
                    self.fillUserFromUserDefaults()
                } catch {
                    print("Erreur de décodage JSON : \(error)")
                }
            }
            
            DispatchQueue.main.async {
               
                self.isNavigationActive = true
            }
        }.resume()
    }
}
