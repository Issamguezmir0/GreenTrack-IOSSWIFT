//
//  HomeViewModel.swift
//  ProjetMobile
//
//  Created by Mac mini 8 on 15/11/2023.
//
//
//  VideosViewModel.swift
//  projetMobile
//
//  Created by Bechir Kefi on 5/11/2023.
//

import Foundation
import SwiftUI

class HomeViewModel: ObservableObject {
    
       @Published var homes: [HomePlayers] = []
       @Published var showError: Bool = false
       @Published var selectedHome: HomePlayers?

    func getHomes() {
        guard let url = URL(string: "http://localhost:8000/home/homes") else { return }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"

        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 {
                do {
                    let jsonData = try JSONDecoder().decode(Homes.self, from: data)
                    DispatchQueue.main.async {
                        self.homes = jsonData.homes
                    }
                } catch let error {
                    print("Error decoding JSON: \(error)")
                    self.showError = true
                }


            } else {
                print("Error fetching homes: \(error?.localizedDescription ?? "Unknown error")")
                self.showError = true
            }
        }.resume()
    }

       
        func getHomesFromAssets() {
            guard let url = URL(string: "http://localhost:8000/home/homes/assets/") else { return }
            
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "GET"
            
            URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 {
                    do {
                        let jsonData = try JSONDecoder().decode(Homes.self, from: data)
                        DispatchQueue.main.async {
                            self.homes = jsonData.homes
                        }
                    } catch {
                        print("Error decoding JSON: \(error)")
                        self.showError = true
                    }
                } else {
                    print("Error fetching homes: \(error?.localizedDescription ?? "Unknown error")")
                    self.showError = true
                }
            }.resume()
        }
        


       func postHomes(home: HomePlayers) {
           guard let url = URL(string: "http://localhost:8000/home/home") else { return }
           
           var urlRequest = URLRequest(url: url)
           urlRequest.httpMethod = "POST"
           urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
           
           do {
               let encodedHome = try JSONEncoder().encode(home)
               urlRequest.httpBody = encodedHome
           } catch {
               print("Error encoding home data: \(error)")
               self.showError = true
               return
           }
           
           URLSession.shared.dataTask(with: urlRequest) { data, response, error in
               if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 {
                   do {
                       let jsonData = try JSONDecoder().decode(Homes.self, from: data)
                       DispatchQueue.main.async {
                           self.homes = jsonData.homes
                       }
                   } catch {
                       print("Error decoding JSON: \(error)")
                       self.showError = true
                   }
               } else {
                   print("Error posting home: \(error?.localizedDescription ?? "Unknown error")")
                   self.showError = true
               }
           }.resume()
       }

       func patchHome(home: HomePlayers) {
           //guard let id = home.id,let url = URL(string: "http://localhost:8000/home/\(id)") else { return }
           let urlString = "http://localhost:8000/home/\(home.id)"
               
               guard let url = URL(string: urlString) else {
                   print("Error creating URL")
                   return
               }
           var urlRequest = URLRequest(url: url)
           urlRequest.httpMethod = "PATCH"
           urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
           
           do {
               let encodedHome = try JSONEncoder().encode(home)
               urlRequest.httpBody = encodedHome
           } catch {
               print("Error encoding home data: \(error)")
               self.showError = true
               return
           }
           
           URLSession.shared.dataTask(with: urlRequest) { data, response, error in
               if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 {
                   do {
                       let jsonData = try JSONDecoder().decode(Homes.self, from: data)
                       DispatchQueue.main.async {
                           self.homes = jsonData.homes
                       }
                   } catch {
                       print("Error decoding JSON: \(error)")
                       self.showError = true
                   }
               } else {
                   print("Error updating home: \(error?.localizedDescription ?? "Unknown error")")
                   self.showError = true
               }
           }.resume()
       }

       func deleteHome(_ id: String) {
           guard let url = URL(string: "http://localhost:8000/home/\(id)") else { return }
           
           var urlRequest = URLRequest(url: url)
           urlRequest.httpMethod = "DELETE"
           
           URLSession.shared.dataTask(with: urlRequest) { data, response, error in
               if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 {
                   do {
                       let jsonData = try JSONDecoder().decode(Homes.self, from: data)
                       DispatchQueue.main.async {
                           self.homes = jsonData.homes
                       }
                   } catch {
                       print("Error decoding JSON: \(error)")
                       self.showError = true
                   }
               } else {
                   print("Error deleting home: \(error?.localizedDescription ?? "Unknown error")")
                   self.showError = true
               }
           }.resume()
       }
    }

