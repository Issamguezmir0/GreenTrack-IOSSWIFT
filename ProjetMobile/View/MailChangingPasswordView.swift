//
//  MailChangingPasswordView.swift
//  ProjetMobile
//
//  Created by IssamGuezmir on 13/11/2023.
//

import SwiftUI

struct MailChangingPasswordView: View {
    @State private var password = ""
    @State private var verifyPassword = ""
    @State private var arePasswordEqual = true
    @ObservedObject var ViewModel: MailChangeViewModel
    @State private var isPasswordValid = true

   
    var body: some View {

        ZStack {
                   VStack(alignment: .leading) {
                   

                       VStack {
                           TextField("Please Enter your Phone", text: $ViewModel.num_tel)
                               .textFieldStyle(RoundedBorderTextFieldStyle())
                               .onChange(of: password, perform: { newValue in
                                   isPasswordValid = isValidPassword(newValue)
                                   arePasswordEqual = checkIfPasswordsEqual()
                               })

                           if !isPasswordValid {
                               Text("Password must be at least 8 characters")
                                   .foregroundColor(.red)
                           }
                       }

                       VStack {
                           SecureField("Enter your new Password", text: $ViewModel.newPassword)
                               .textFieldStyle(RoundedBorderTextFieldStyle())
                               .onChange(of: verifyPassword, perform: { newValue in
                                   
                                   arePasswordEqual = checkIfPasswordsEqual()
                               })

                           if !arePasswordEqual {
                               Text("Passwords do not match")
                                   .foregroundColor(.red)
                           }
                       }
                       Spacer()
                               .frame(height: 30)
                       VStack {
                           Button("Change password") {
                           action: do {
                               ViewModel.send()
                               //viewModel2.authenticateUserProfile()
                              // navigateToLocation = true
                           }
                             
                           }
                           .font(.title2)
                           .fontWeight(.bold)
                           .frame(maxWidth: .infinity)
                           .padding()
                           .background(Color.green)
                           .foregroundColor(.white)
                           .cornerRadius(10)
                           .disabled(!isPasswordValid || !arePasswordEqual)
                           // Le bouton est désactivé si le mot de passe n'est pas valide ou les mots de passe ne correspondent pas
                       }
                   }
               }.padding()
           }
           

           func checkIfPasswordsEqual() -> Bool {
               return password == verifyPassword
           }
    func isValidPassword(_ password: String) -> Bool {
        return password.count >= 8
    }

       }

struct MailChangingPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        MailChangingPasswordView(ViewModel: MailChangeViewModel())
    }
}
