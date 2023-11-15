//
//  ContentView.swift
//  VideoScroll
//
//  Created by Bechir Kefi on 7/11/2023.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: HomeVideoViewModel
        
    var body: some View {
        
        
        let persistenceController = PersistenceController()
        TabView {
            HomeUIView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }

            contenttView(data: $viewModel.data, currentVideoIndex: $viewModel.currentVideoIndex, viewModel: viewModel)

                .environment(\.managedObjectContext, persistenceController.container.viewContext )

                .tabItem {
                    Image(systemName: "play.fill")
                    Text("Player")
                }


            ProfileView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }

            ContenView ()
                .tabItem {
                    Image(systemName: "cloud.sun.fill")
                    Text("Calcul")
                }

            SwiftUIView()
                .tabItem {
                    Image(systemName: "map.fill")
                    Text("Map")
                }

            ChallengeView()
                .tabItem {
                    Image(systemName: "star.fill")
                    Text("Challenge")
                }
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
