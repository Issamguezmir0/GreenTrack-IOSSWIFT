//
//  Video.swift
//  projetMobile
//
//
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
    let details: String
    let date: Date?
    let location : String
    let isFree : Bool?
    let organisateurs : [String]
    let participants : [String]
    let image: String?
    let price : String
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case description
        case details
        case date
        case location
        case isFree
        case organisateurs
        case participants
        case image
        case price

    }
  
    
    init(from decoder: Decoder) throws {
     
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.description = try container.decode(String.self, forKey: .description)
        
        if let dateString = try container.decodeIfPresent(String.self, forKey: .date){
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"

            if let date =  dateFormatter.date(from: dateString) {
                self.date = date
            } else {
                throw DecodingError.dataCorruptedError(forKey: .date, in: container, debugDescription: "Date string does not match format expected by formatter.")
            }
        }else {
            self.date = nil
        }
        self.details = try container.decode(String.self, forKey: .details)
        self.location = try container.decode(String.self, forKey: .location)
        self.isFree = try container.decode(Bool.self, forKey: .isFree)
        self.organisateurs = try container.decode([String].self, forKey: .organisateurs)
        self.participants = try container.decode([String].self, forKey: .participants)
        self.image = try container.decode(String.self, forKey: .image)
        self.price = try container.decode(String.self, forKey: .price)
    }
}


