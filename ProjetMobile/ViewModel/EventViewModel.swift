//
//  VideosViewModel.swift
//  projetMobile
//
//  Created by Bechir Kefi on 5/11/2023.
//

import Foundation
import SwiftUI

class EventViewModel: ObservableObject {
   @Published var events: [Event] = []
   @Published var showError: Bool = false
   @Published var selectedEvent: Event?
   @Published var selectedEventTitle: String?

    func getEvents() {
        guard let url = URL(string: "http://172.20.10.5:8000/challenge/event") else { return }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"

        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 {
                do {
                    let jsonData = try JSONDecoder().decode(Events.self, from: data)
                    DispatchQueue.main.async {
                        self.events = jsonData.events
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                    DispatchQueue.main.async {
                        self.showError = true
                    }
                }
            } else {
                print("Error fetching events: \(error?.localizedDescription ?? "Unknown error")")
                DispatchQueue.main.async {
                    self.showError = true
                }
            }
        }.resume()
    }




   func postEvents(events: Event) {
       guard let url = URL(string: "http://172.20.10.5:8000/challenge/events") else { return }
       
       var urlRequest = URLRequest(url: url)
       urlRequest.httpMethod = "POST"
       urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
       
       do {
           let challengeData = try JSONEncoder().encode(events)
           urlRequest.httpBody = challengeData
       } catch {
           print("Error encoding challenge data: \(error)")
           self.showError = true
           return
       }

       
       URLSession.shared.dataTask(with: urlRequest) { data, response, error in
           if let response = response as? HTTPURLResponse, response.statusCode == 200 {
               print("Successfully added challenge")
               // Handle success, update UI or perform any necessary actions
           } else {
               print("Error adding challenge: \(error?.localizedDescription ?? "Unknown error")")
               self.showError = true
               // Handle failure, show an error message or perform any necessary actions
           }
       }.resume()

   }

//   func patchEvent(event: Event) {
//       guard let id = event.id, let url = URL(string: "http://172.20.10.5:8000/challenge/\(id)") else { return }
//
//       var urlRequest = URLRequest(url: url)
//       urlRequest.httpMethod = "PATCH"
//       urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
//
//       do {
//           let challengeData = try JSONEncoder().encode(events)
//           urlRequest.httpBody = challengeData
//       } catch {
//           print("Error encoding challenge data: \(error)")
//           self.showError = true
//           return
//       }
//
//       URLSession.shared.dataTask(with: urlRequest) { data, response, error in
//           if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 {
//               do {
//                   let jsonData = try JSONDecoder().decode(Events.self, from: data)
//                   DispatchQueue.main.async {
//                       self.events = jsonData.events
//                   }
//               } catch {
//                   print("Error decoding JSON: \(error)")
//                   self.showError = true
//               }
//           } else {
//               print("Error updating video: \(error?.localizedDescription ?? "Unknown error")")
//               self.showError = true
//           }
//       }.resume()
//   }

//   func deleteVideo(_ id: String) {
//       guard let url = URL(string: "http://172.20.10.5:8000/challenge/\(id)") else { return }
//       
//       var urlRequest = URLRequest(url: url)
//       urlRequest.httpMethod = "DELETE"
//       
//       URLSession.shared.dataTask(with: urlRequest) { data, response, error in
//           if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 {
//               do {
//                   let challengeData = try JSONEncoder().encode(events)
//                   urlRequest.httpBody = challengeData
//               } catch {
//                   print("Error encoding challenge data: \(error)")
//                   self.showError = true
//                   return
//               }
//           } else {
//               print("Error deleting video: \(error?.localizedDescription ?? "Unknown error")")
//               self.showError = true
//           }
//       }.resume()
//   }
}

