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
        guard let id = UserDefaults.standard.string(forKey: "userId") else {
            print("Erreur lors de la récupération de l'ID utilisateur depuis UserDefaults")
            return
        }
        
        self.email = UserDefaults.standard.string(forKey: "userEmail") ?? ""
        self.num_tel = UserDefaults.standard.string(forKey: "userPhone") ?? ""
        self.fullname = UserDefaults.standard.string(forKey: "userFullName") ?? ""
    }
    
    func authenticateUserProfile() {
        guard let token = UserDefaults.standard.string(forKey: "accessToken") else {
            print("Erreur lors de la récupération du jeton depuis UserDefaults")
            return
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

                    guard let userDictionary = jsonResponse?["user"] as? [String: Any] else {
                        print("Failed to retrieve user information from JSON response")
                        return
                    }

                    DispatchQueue.main.async {
                        if let id = userDictionary["id"] as? String {
                            print("ID from viewmodel: \(id)")
                            UserDefaults.standard.set(id, forKey: "userId")
                        } else {
                            print("Failed to retrieve ID from JSON response")
                        }

                        if let email = userDictionary["email"] as? String {
                            print("email from viewmodel: \(email)")
                            UserDefaults.standard.set(email, forKey: "userEmail")
                        } else {
                            print("Failed to retrieve email from JSON response")
                        }

                        if let fullname = userDictionary["fullname"] as? String {
                            print("fullname from viewmodel: \(fullname)")
                            UserDefaults.standard.set(fullname, forKey: "userFullName")
                        } else {
                            print("Failed to retrieve fullname from JSON response")
                        }

                        if let num_tel = userDictionary["num_tel"] as? String {
                            print("num_tel from viewmodel: \(num_tel)")
                            UserDefaults.standard.set(num_tel, forKey: "userPhone")
                        } else {
                            print("Failed to retrieve num_tel from JSON response")
                        }

                        UserDefaults.standard.synchronize()
                        self.fillUserFromUserDefaults()
                    }
                } catch {
                    print("Erreur de décodage JSON : \(error)")
                }
            }
        }.resume()
    }
}
