//
//  Home.swift
//  ProjetMobile
//
//  Created by Mac mini 8 on 15/11/2023.
//

import Foundation


    enum CodingKeys: String, CodingKey {
        case message
    }


struct Homes: Codable {
    var message: String
    var homes: [HomePlayers]
    
    enum CodingKeys: String, CodingKey {
        case message
        case homes
    }
}


struct HomePlayers: Identifiable, Codable {
    var id: String
    var idUser: String
    var description: String?
//    var image: String
//    var likes: String
//    var comments: String

    enum CodingKeys: String, CodingKey {
        case id
        case idUser
        case description  // Update the key to "description"
//        case image
//        case likes
//        case comments
    }
}






