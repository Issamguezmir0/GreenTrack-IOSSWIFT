//
//  SignInView.swift
//  ProjetMobile
//
//  Created by IssamGuezmir on 6/11/2023.
//

import SwiftUI

struct SignInView: View {
    @State private var navigateToLocation = false
    @ObservedObject var ViewModel: LoginViewModel
    @State private var isEmailValid = true
    @State private var isPasswordValid = true


    var body: some View {
        NavigationStack {
            ZStack {
                VStack(alignment: .leading){
                    VStack{
                        Text("Hi, Welcome back! 👋")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .padding(.bottom, 5)

                        Text("Hello again, you've been missed!")
                            .font(.title3)
                            .foregroundColor(.gray)
                            .padding(.bottom, 20)
                    }
                    .padding()

                    VStack{
                        Text("Email :")
                            .font(.title3)
                            .foregroundColor(.green)
                            .frame(alignment: .leading)
                    }

                    VStack{
                        TextField("", text: $ViewModel.email)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .onChange(of: ViewModel.email) { newValue in
                                isEmailValid = isValidEmail(newValue)
                            }

                        if !isEmailValid {
                            Text("Invalid email format")
                                .foregroundColor(.red)
                                .padding(.top, 5)
                        }
                    }

                    VStack{
                        Text("Password :")
                            .font(.title3)
                            .foregroundColor(.green)
                            .frame(alignment: .leading)
                    }

                    VStack{
                        SecureField("", text: $ViewModel.password)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .onChange(of: ViewModel.password) { newValue in
                                isPasswordValid = newValue.count >= 8
                            }

                        if !isPasswordValid {
                            Text("Password must be at least 8 characters")
                                .foregroundColor(.red)
                                .padding(.top, 5)
                        }
                    }

                    HStack{
                        Spacer()

                        NavigationLink(destination: ForgotPasswordView()){
                            Text(" Forgot Password ? ")
                                .font(.callout)
                                .foregroundColor(.gray)
                        }
                    }

                    VStack{
                        
                      
                        Button (action :{
                            ViewModel.login()
                            navigateToLocation = true
                        }){
                            Text("Login")
                        }
                        .font(.title2)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(50)

                        Text("Or With")
                            .foregroundColor(.gray)
                            .frame(alignment: .leading)
                    }

                    HStack {
                        Button(action: {

                        }) {
                            HStack {
                                Image("facebook")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 20, height: 20)

                                Text("Facebook")
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)

                        Button(action: {

                        }) {
                            HStack {
                                Image("Gmail")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 20, height: 20)

                                Text("Gmail")
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                }
                .padding()

                VStack{
                    Spacer()
                    HStack{
                        Text("Don't have an account ?")
                            .font(.caption)
                        NavigationLink(destination: SignUpView(ViewModel1: userViewModel1())) {
                            Text("Sign up")
                                .font(.caption)
                                .foregroundColor(.green)

                        }
                    }.navigationBarBackButtonHidden(true)
                }
            }
        }
    }

    func isValidEmail(_ email: String) -> Bool {
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}")
        return emailPredicate.evaluate(with: email)
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView(ViewModel: LoginViewModel())
    }
}
