//
//  GetStartedView.swift
//  ProjetMobile
//
//  Created by IssamGuezmir on 6/11/2023.
//

import SwiftUI

struct GetStartedView: View {
    @State private var navigateToLocation = false
    var body: some View {
        NavigationStack{
            VStack {
                Image("IMG_2958")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 300)
                
              VStack {
                   NavigationLink(destination: SignInView(ViewModel: LoginViewModel()), isActive: $navigateToLocation) {
                        
                    }
                    
                    .hidden()
                    Spacer()
                    Button(action: {
                        navigateToLocation = true
                        
                    })
                    {
                        Text("  GET STARTED!    ")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.green)
                            .cornerRadius(30)
                            .frame(width: 300, height: 150)
                    }
                    
                }
                
            }
        }
    }
}

struct GetStartedView_Previews: PreviewProvider {
    static var previews: some View {
        GetStartedView()
    }
}
