//
//  APIManager.swift
//  ProjetMobile
//
//  Created by issam guezmir on 13/11/2023.
//

import Foundation

class APIManager {
    
    static let shared = APIManager()
    private let baseURL = "http://localhost:3002"
    /*
    func signup(fullname: String, password: String, email: String, completion: @escaping(Result<User, Error>) -> Void) {
        guard let signupURL = URL(string: baseURL + "/auth/signup") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }

        var request = URLRequest(url: signupURL)
        request.httpMethod = "POST"
        
        let body: [String: Any] = ["fullname": "test", "password": "123456789", "email": "test@gmail.com"]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    print("1")
                    let user = try JSONDecoder().decode(User.self, from: data)
                    completion(.success(user))
                } catch {
                    print("2")
                    completion(.failure(error))
                }
            } else if let error = error {
                completion(.failure(error))
            }
        }.resume()
    }*/
    func signup(data: Data, completion: @escaping (Result<Void, Error>) -> Void) {
            // Replace the placeholder URL with your actual signup endpoint
            let url = URL(string: "http://localhost:3002/auth/signup")!
            
            var request = URLRequest(url: url)
            request.httpMethod = "PUT"
            request.httpBody = data
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                // Handle the API response
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(()))
                }
            }.resume()
        }
    
    func login(data: Data, completion: @escaping (Result<Data, Error>) -> Void) {
        let url = URL(string: "http://localhost:3002/auth/signin")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = data
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            // Handle the API response
            if let error = error {
                completion(.failure(error))
            } else {
                
                completion(.success(data!))
            }
        }.resume()
    }
}
