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

struct Events: Codable {
    var message: String
    var events: [Event]
    
    enum CodingKeys: String, CodingKey {
        case message
        case events
    }
}


struct Event: Identifiable, Codable {
    let id: String
    let title: String
    let description: String

    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case description

    }
    
    init(id: String = "Default ID",
          title: String = "Default Title",
          description: String = "Default Description"
       ) {
         self.id = id
         self.title = title
         self.description = description
 
     }
}


