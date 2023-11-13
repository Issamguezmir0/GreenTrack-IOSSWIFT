//
//  ProjetMobileApp.swift
//  ProjetMobile
//
//  Created by IssamGuezmir on 6/11/2023.
//

import SwiftUI

@main
struct ProjetMobileApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
          SignUpView(userViewModel1: userViewModel1() )
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
