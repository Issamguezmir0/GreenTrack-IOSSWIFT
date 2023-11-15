//
//  VideosViewModel.swift
//  projetMobile
//
//  Created by Bechir Kefi on 5/11/2023.
//

import Foundation
import SwiftUI

class VideosViewModel: ObservableObject {
   @Published var videos: [VideoPlayers] = []
   @Published var showError: Bool = false
   @Published var selectedVideo: VideoPlayers?

   func getVideos() {
       guard let url = URL(string: "http://localhost:8000/video/videos") else { return }
       
       var urlRequest = URLRequest(url: url)
       urlRequest.httpMethod = "GET"
       
       URLSession.shared.dataTask(with: urlRequest) { data, response, error in
           if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 {
               do {
                   let jsonData = try JSONDecoder().decode(Videos.self, from: data)
                   DispatchQueue.main.async {
                       self.videos = jsonData.videos
                   }
               } catch {
                   print("Error decoding JSON: \(error)")
                   self.showError = true
               }
           } else {
               print("Error fetching videos: \(error?.localizedDescription ?? "Unknown error")")
               self.showError = true
           }
       }.resume()
   }
   
    func getVideosFromAssets() {
        guard let url = URL(string: "http://localhost:8000/video/videos/names/") else { return }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 {
                do {
                    let jsonData = try JSONDecoder().decode(Videos.self, from: data)
                    DispatchQueue.main.async {
                        self.videos = jsonData.videos
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                    self.showError = true
                }
            } else {
                print("Error fetching videos: \(error?.localizedDescription ?? "Unknown error")")
                self.showError = true
            }
        }.resume()
    }
    


   func postVideo(video: VideoPlayers) {
       guard let url = URL(string: "http://localhost:8000/video/video") else { return }
       
       var urlRequest = URLRequest(url: url)
       urlRequest.httpMethod = "POST"
       urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
       
       do {
           let encodedVideo = try JSONEncoder().encode(video)
           urlRequest.httpBody = encodedVideo
       } catch {
           print("Error encoding video data: \(error)")
           self.showError = true
           return
       }
       
       URLSession.shared.dataTask(with: urlRequest) { data, response, error in
           if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 {
               do {
                   let jsonData = try JSONDecoder().decode(Videos.self, from: data)
                   DispatchQueue.main.async {
                       self.videos = jsonData.videos
                   }
               } catch {
                   print("Error decoding JSON: \(error)")
                   self.showError = true
               }
           } else {
               print("Error posting video: \(error?.localizedDescription ?? "Unknown error")")
               self.showError = true
           }
       }.resume()
   }

   func patchVideo(video: VideoPlayers) {
       guard let id = video.id, let url = URL(string: "http://localhost:8000/video/\(id)") else { return }
       
       var urlRequest = URLRequest(url: url)
       urlRequest.httpMethod = "PATCH"
       urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
       
       do {
           let encodedVideo = try JSONEncoder().encode(video)
           urlRequest.httpBody = encodedVideo
       } catch {
           print("Error encoding video data: \(error)")
           self.showError = true
           return
       }
       
       URLSession.shared.dataTask(with: urlRequest) { data, response, error in
           if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 {
               do {
                   let jsonData = try JSONDecoder().decode(Videos.self, from: data)
                   DispatchQueue.main.async {
                       self.videos = jsonData.videos
                   }
               } catch {
                   print("Error decoding JSON: \(error)")
                   self.showError = true
               }
           } else {
               print("Error updating video: \(error?.localizedDescription ?? "Unknown error")")
               self.showError = true
           }
       }.resume()
   }

   func deleteVideo(_ id: String) {
       guard let url = URL(string: "http://localhost:8000/video/\(id)") else { return }
       
       var urlRequest = URLRequest(url: url)
       urlRequest.httpMethod = "DELETE"
       
       URLSession.shared.dataTask(with: urlRequest) { data, response, error in
           if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 {
               do {
                   let jsonData = try JSONDecoder().decode(Videos.self, from: data)
                   DispatchQueue.main.async {
                       self.videos = jsonData.videos
                   }
               } catch {
                   print("Error decoding JSON: \(error)")
                   self.showError = true
               }
           } else {
               print("Error deleting video: \(error?.localizedDescription ?? "Unknown error")")
               self.showError = true
           }
       }.resume()
   }
}

