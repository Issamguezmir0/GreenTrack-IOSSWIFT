//
//  PostsView.swift
//  ProjetMobile
//
//  Created by Apple Esprit on 14/11/2023.
//

import SwiftUI

struct PostsView: View  {
    
    var body: some View {
        ForEach(1..<20) { _ in
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill(LinearGradient(
                        gradient: Gradient(colors: [.blue, .green, .orange]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing)
                    )
                    .frame(height: 300)
                    .padding(.horizontal, 16)
                
                VStack(spacing: 15) {
                    HStack(spacing: 15) {
                        // Your profile image or placeholder
                        Image("IMG_2958")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                            .shadow(radius: 3)
                        
                        // User information
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Use public transportation")
                                .font(.title2)
                                .fontWeight(.heavy)
                                .foregroundColor(.black)
                        }
                        
                        Spacer(minLength: 0)
                    }
                    
                    // Your posts or content
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.gray.opacity(0.2))
                            .frame(maxWidth: .infinity)
                            .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                        
                        
                    }
                    
                }}}}}
