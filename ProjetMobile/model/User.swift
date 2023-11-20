//
//  User.swift
//  ProjetMobile
//
//  Created by MacOS on 7/11/2023.
//

import Foundation
import SwiftUI
import CoreData

struct User : Codable{
    
    var idUser : Int
    var fullname : String
    var email : String
    var password : String
    var num_tel : String
  
}
