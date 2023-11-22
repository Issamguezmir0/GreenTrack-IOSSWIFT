//
//  Video.swift
//  projetMobile
//
//  Created by Bechir Kefi on 5/11/2023.
//

import Foundation

struct ErrorData: Codable {
    var message: String
    
    enum CodingKeys: String, CodingKey {
        case message
    }
}

struct Videos: Codable {
    var message: String
    var videos: [VideoPlayers]
    
    enum CodingKeys: String, CodingKey {
       case message
        case videos
    }
}


struct VideoPlayers: Identifiable, Codable {
    var id: String?
    var title: String?
    var url: String?
    var likes: Int?
   // var name: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case url
        case likes
      //  case name
    }
}


