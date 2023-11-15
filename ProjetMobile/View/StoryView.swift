//
//  StoryView.swift
//  ProjetMobile
//
//  Created by Apple Esprit on 14/11/2023.
//

import SwiftUI

struct StoryView: View {
    @Binding var showStory: Bool
    let storyNamespace: Namespace.ID
    let thumbNamespace: Namespace.ID
    let index: Int
    var body: some View {
        ZStack{
            if showStory{
                ZStack{
                    //backround
                    Image("story\(index)")
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 4))
                    
                }
                .matchedGeometryEffect(id:"story\(index)", in: storyNamespace)
                .transition(.scale(scale: 0.99))

                
            }
            
            
            VStack{
                HStack{
                    if showStory{
                        Image("thumb\(index)")
                            .resizable()
                            .scaledToFit()
                            .clipShape(Circle())
                            .matchedGeometryEffect(id:"thumb\(index)", in: thumbNamespace)
                            .transition(.scale(scale: 0.99))

                            .frame(width: 50, height: 50)
                            .padding()
                    }
                    Spacer()
                }
                Spacer()
            }
            .padding(.top,24)
        }
    }
}

