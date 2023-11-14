//
//  APIManager.swift
//  ProjetMobile
//
//  Created by issam guezmir on 13/11/2023.
//

import Foundation

class APIManager {
    
    static let shared = APIManager()
    private let baseURL = "http://localhost:3000"
    
    func signup(fullname: String, password: String, email: String, completion: @escaping(Result<User, Error>) -> Void) {
        guard let signupURL = URL(string: baseURL + "/auth/signup") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }

        var request = URLRequest(url: signupURL)
        request.httpMethod = "PUT"
        
        let body: [String: Any] = ["fullname": fullname, "password": password, "email": email]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    let user = try JSONDecoder().decode(User.self, from: data)
                    completion(.success(user))
                } catch {
                    completion(.failure(error))
                }
            } else if let error = error {
                completion(.failure(error))
            }
        }.resume()
    }
}
