//
//  ChatView.swift
//  MobileApp
//
//  Created by ichrakbenmahmoud on 8/11/2023.
//
import SwiftUI



struct ChatView: View {
    @State private var isNavigationActive = false // Utilisez cet état pour activer la navigation

    var body: some View {
        NavigationView {
            ZStack {
                Color.clear
                    .ignoresSafeArea()
                VStack{
                   
        
                    
                    Image("5625")
                        .resizable()
                        .frame(width: 400, height: 300)

                    Text("Welcome To EcoTrack")
                                    .font(.title)
                                    .padding(.bottom, 20)
                                    .bold()
                                
                                Text("“ Need help or information? We are just a message away. Feel free to contact us at any time. Your satisfaction is our priority “")
                                    .multilineTextAlignment(.center)
                                    .font(.headline)
                                    .padding(.bottom, 80)
                                    .padding(.horizontal, 30)
                    
                    
                    
                    
                    NavigationLink(
                                        destination: Messagerie(), // Replace 'MessagerieView()' with your actual destination view
                                        isActive: $isNavigationActive,
                                        label: {
                                            EmptyView() // This is used to hide the navigation link
                                        }
                                    )

                                    Button(action: {
                                        
                                        print("Bouton appuyé")
                                        isNavigationActive = true 
                                    }) {
                                        Label(
                                            title: {
                                                Text("Let's Go Chat")
                                                    .fontWeight(.semibold)
                                                    .font(.title)
                                            },
                                            icon: {
                                                Image(systemName: "message")
                                                    .font(.title)
                                            }
                                        )
                                    }
                                    .padding()
                                    .background(LinearGradient(gradient: Gradient(colors: [Color.yellow, Color.green]), startPoint: .leading, endPoint: .trailing))
                                    .foregroundColor(.white)
                                    .cornerRadius(30.0)
                }
            }
            .navigationBarHidden(true)
        }
    }
}


struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}


