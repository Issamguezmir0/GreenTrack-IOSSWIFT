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
    let details: String
    let date: Date?
    let location : String
    let isFree : Bool
    //let organiser : [String]
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case description
        case details
        case date
        case location
        case isFree
       // case organiser
        

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
        //self.organiser = try container.decode([String].self, forKey: .organiser)
        
    }
}


