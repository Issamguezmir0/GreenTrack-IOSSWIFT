//
//  ForgotPasswordView.swift
//  ProjetMobile
//
//  Created by MacOS on 7/11/2023.
//

import SwiftUI

struct ForgotPasswordView: View {
    @State private var num_tel = ""
    @State private var isPasswordResetSent = false
    @State private var password = ""
    @State private var isPhoneNumberValid = true
    @State private var navigateToLocation = false
    @ObservedObject var ViewModel: ForgetViewModel


    
    var body: some View {
        VStack {
            VStack {
                Text("Enter your phone number please ")
                    .font(.title3)
                    .foregroundColor(.green)
                    .frame(alignment: .leading)
            }
            
            VStack {
                TextField("+216", text: $ViewModel.num_tel)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .onChange(of: num_tel, perform: { newValue in
                        isPhoneNumberValid = isValidPhoneNumber(newValue)
                    })
                
                if !isPhoneNumberValid {
                    Text("Invalid phone number , should start with +216")
                        .foregroundColor(.red)
                }
            }
            Spacer()
                    .frame(height: 30)
            
            VStack {
                NavigationLink( destination: CheckCodeView(ViewModel: CheckViewModel()), isActive: $navigateToLocation){
                    
                }
                Button("Send") {
                action: do {
                    ViewModel.send()
                    //viewModel2.authenticateUserProfile()
                    navigateToLocation = true
                }
                }
                .font(.title2)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            
        }.padding()
    }
    
    func isValidPhoneNumber(_ phoneNumber: String) -> Bool {
        // Check if the phoneNumber starts with "+216"
        return phoneNumber.hasPrefix("+216") && phoneNumber.count >= 5
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView(ViewModel: ForgetViewModel())
    }
}

