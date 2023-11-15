//
//  Home.swift
//  InstaFeed
//
//  Created by Bechir Kefi on 14/11/2023.
//

import SwiftUI

struct Feed: View {
    var size: CGSize
    var safeArea: EdgeInsets
    
    @State private var reels: [Reel] = reelsData
    @State private var likedCounter: [Like] = []
    
    var body: some View {
        ScrollView(.vertical) {
            LazyVStack(spacing: 850) {
                ForEach($reels) { $reel in
                    ReelView(reel: $reel, likedCounter: $likedCounter, size: size, safeArea: safeArea, reels: reels)
                   
                }
                .frame(maxWidth: .infinity)
            }
        }
        .scrollIndicators(.hidden)
        .background(.black)
        .environment(\.colorScheme, .dark)
    }
}

struct Feed_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
