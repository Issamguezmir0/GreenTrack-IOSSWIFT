//
//  userViewModel1.swift
//  ProjetMobile
//
//  Created by issam guezmir on 13/11/2023.
//

import SwiftUI

class userViewModel1: ObservableObject {
    
    @Published var fullname = ""
    @Published var password = ""
    @Published var password1 = ""
    @Published var email = ""
    @Published var registrationStatus: registrationStatus?
    
    enum registrationStatus {
        case idle, registering, success(User), failure(Error)
    }
    
    func signup() {
        DispatchQueue.main.async {
            self.registrationStatus = .registering
            APIManager.shared.signup(fullname: self.fullname, password: self.password, email: self.email) { (result: Result<User, Error>) in
                switch result {
                case .success(let user):
                    DispatchQueue.main.async {
                        self.registrationStatus = .success(user)
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        self.registrationStatus = .failure(error)
                    }
                }
            }
        }
    }
}
