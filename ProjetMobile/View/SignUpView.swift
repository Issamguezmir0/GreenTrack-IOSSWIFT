//
//  SignUpView.swift
//  ProjetMobile
//
//  Created by MacOS on 7/11/2023.
//

import SwiftUI

struct SignUpView: View {
    
    @State private var navigateToLocation = false
    @State private var verifyPass = ""
    @ObservedObject var ViewModel1: userViewModel1
    @State private var isFullNameValid = true
    @State private var isEmailValid = true
    @State private var isPasswordValid = true
    @State private var isPasswordMatch = true
    
    var isFormValid: Bool {
           return isFullNameValid && isEmailValid && isPasswordValid && isPasswordMatch
       }

    var body: some View {
        NavigationStack{
        ZStack {
            VStack(alignment: .leading ) {
                Text("Create an account😀")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 5)
                    
                Text("Connect with your friends today! 👋")
                    .font(.title3)
                    .foregroundColor(.gray)
                    .frame(alignment: .leading)
                    .padding(.bottom, 20)
                    
                    

                Text("Full Name : ")
                    .font(.title3)
                    .foregroundColor(.green)
                    .frame(alignment: .leading)
                    
                

                VStack {
                    TextField("", text: $ViewModel1.fullname)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                        .onChange(of: ViewModel1.fullname) { newValue in
                                    isFullNameValid = newValue.count >= 8
                                }

                            if !isFullNameValid {
                                Text("Full name must be at least 8 characters.")
                                    .foregroundColor(.red)
                            }
                }

                Text("Email Address :")
                    .font(.title3)
                    .foregroundColor(.green)
                    .frame(alignment: .leading)
                    

                VStack {
                    TextField("", text: $ViewModel1.email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .onChange(of: ViewModel1.email) { newValue in
                                   isEmailValid = isValidEmail(newValue)
                               }

                           if !isEmailValid {
                               Text("Invalid email address.")
                                   .foregroundColor(.red)
                           }
                       
                }

                VStack {
                    Text("Password :")
                        .font(.title3)
                        .foregroundColor(.green)
                        .frame(alignment: .leading)
                        .padding(.leading, -180)

                    SecureField("", text: $ViewModel1.password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .onChange(of: ViewModel1.password) { newValue in
                                   isPasswordValid = newValue.count >= 8
                               }

                           if !isPasswordValid {
                               Text("Password must be at least 8 characters.")
                                   .foregroundColor(.red)
                           }
                        

                    Text("Verify password :")
                        .font(.title3)
                        .foregroundColor(.green)
                        .frame(alignment: .leading)
                        .padding(.leading, -180)
                    

                    VStack {
                        SecureField("", text: $verifyPass)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .background(Color.red.opacity(isPasswordMatch ? 0 : 0.3))
                            .onChange(of: verifyPass) { newValue in
                                isPasswordMatch = newValue == ViewModel1.password
                            }

                        if !isPasswordMatch {
                            Text("Passwords do not match.")
                                .foregroundColor(.red)
                        }
                    }
                    
                        
                        
                        
                    
                    NavigationLink(destination: SignInView(ViewModel: LoginViewModel()), isActive: $navigateToLocation) {
                        
                    }
                    Spacer()
                            .frame(height: 20)
                    Button("Sign Up") {
                       
                    action: do {
                        ViewModel1.signup()
                        navigateToLocation = true
                    }}
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

                    HStack {
                        Button(action: {
                            // Action to perform when the Facebook button is pressed
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
                        .padding()

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
                        .padding()
                    }
                }
            }.padding()
            

            VStack {
                Spacer()
                HStack {
                    Text("Already have an account ?")
                        .font(.caption)
                    NavigationLink(destination: SignInView(ViewModel: LoginViewModel())){ Text("Login")
                            .font(.caption)
                            .foregroundColor(.green)
                    }
                    
                }
            }
        }
        }
    }
    func isValidEmail(_ email: String) -> Bool {
           let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
           return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
       }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(ViewModel1: userViewModel1())
    }
}
