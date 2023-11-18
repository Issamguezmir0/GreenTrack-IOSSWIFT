//
//  ProfileViewModel.swift
//  ProjetMobile
//
//  Created by issam guezmir on 18/11/2023.
//

/*import Foundation
class ProfileViewModel: ObservableObject {
    @Published var user: User?
    @Published var isLoading = false
    @Published var error: Error?

    @Published var fullName: String = ""
    @Published var adresse: String = ""
    @Published var email: String = ""
    @Published var cin: String = ""
    @Published var num_tel: String = ""
    @Published var img: String = ""
    @Published var age: Int = 0
    @Published var isNavigationActive: Bool = false

    private let apiManager = APIManager.shared

    func fillUserFromUserDefaults() {
        DispatchQueue.main.async {
            self.isLoading = true // Show loading view
        }
        guard let userId = UserDefaults.standard.string(forKey: "userId") else {
            return print("Error getting user ID from UserDefaults")
        }
        
       // self.role = UserDefaults.standard.string(forKey: "userRole") ?? ""
      //  self.location = UserDefaults.standard.string(forKey: "userlocation") ?? ""
        self.email = UserDefaults.standard.string(forKey: "userEmail") ?? ""
        //self.bio = UserDefaults.standard.string(forKey: "userbio") ?? ""
        self.fullName = UserDefaults.standard.string(forKey: "userFullName") ?? ""
        self.num_tel = UserDefaults.standard.string(forKey: "userNum_tel") ?? ""

    }

    init() {
        fillUserFromUserDefaults()
        authenticateUserProfile()
    }

    func authenticateUserProfile() {
        guard let token = UserDefaults.standard.string(forKey: "accessToken") else {
            return print("Erreur lors de l'obtention du jeton")
        }

        let apiUrl = URL(string: "http://172.20.10.3:9090/api/users/authenticate-profile")!

        do {
            var request = URLRequest(url: apiUrl)
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.addValue(token, forHTTPHeaderField: "Authorization")

            URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    print("Erreur: \(error.localizedDescription)")
                } else if let data = data {
                    do {
                        let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]

                        guard let userInfo = jsonResponse?["profile"] as? [String: Any] else {
                            print("Impossible de récupérer les informations du profil depuis la réponse JSON")
                            return
                        }

                        // Mise à jour des propriétés du ViewModel avec les nouvelles données du profil
                        DispatchQueue.main.async {
                            self.fullName = userInfo["fullname"] as? String ?? ""
                            self.adresse = userInfo["adresse"] as? String ?? ""
                            self.email = userInfo["email"] as? String ?? ""
                            self.cin = userInfo["cin"] as? String ?? ""
                            self.num_tel = userInfo["num_tel"] as? String ?? ""
                            self.img = userInfo["img"] as? String ?? ""
                            self.age = userInfo["age"] as? Int ?? 0

                            // Save the user profile data to UserDefaults
                            UserDefaults.standard.set(self.fullName, forKey: "userFullName")
                            UserDefaults.standard.set(self.adresse, forKey: "userAdresse")
                            UserDefaults.standard.set(self.email, forKey: "userEmail")
                            UserDefaults.standard.set(self.cin, forKey: "userCIN")
                            UserDefaults.standard.set(self.num_tel, forKey: "userNumTel")
                            UserDefaults.standard.set(self.img, forKey: "userImg")
                            UserDefaults.standard.set(self.age, forKey: "userAge")

                            self.isLoading = false
                            self.isNavigationActive = true
                        }
                    } catch {
                        print("Erreur lors de l'analyse JSON : \(error.localizedDescription)")
                    }
                }
            }.resume()

        } catch {
            print("Erreur : \(error.localizedDescription)")
        }
    }
}*/

