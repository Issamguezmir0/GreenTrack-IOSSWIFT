//
//  SignUpView.swift
//  ProjetMobile
//
//  Created by MacOS on 7/11/2023.
//

import SwiftUI

struct SignUpView: View {
    
    @State private var navigateToLocation = false

    @ObservedObject var userViewModel1: userViewModel1
    var body: some View {
        NavigationStack{
        ZStack {
            VStack(alignment: .leading ) {
                Text("Create an account😀")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    
                Text("Connect with your friends today! 👋")
                    .font(.title3)
                    .foregroundColor(.gray)
                    .frame(alignment: .leading)
                    

                Text("Full Name : ")
                    .font(.title3)
                    .foregroundColor(.green)
                    .frame(alignment: .leading)
                    
                    .fontWeight(.bold)
                

                VStack {
                    TextField("Enter your fullname", text: $userViewModel1.fullname)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                }

                Text("Email Address :")
                    .font(.title3)
                    .foregroundColor(.green)
                    .frame(alignment: .leading)
                    
                    .fontWeight(.bold)

                VStack {
                    TextField("Enter your Email address", text: $userViewModel1.email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                       
                }

                VStack {
                    Text("Password")
                        .font(.title3)
                        .foregroundColor(.green)
                        .frame(alignment: .leading)
                        .padding(.leading, -180)
                        .fontWeight(.bold)

                    SecureField("Please Enter your Password", text: $userViewModel1.password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        

                    Text("Verify password")
                        .font(.title3)
                        .foregroundColor(.green)
                        .frame(alignment: .leading)
                        .padding(.leading, -180)
                        .fontWeight(.bold)
                    

                    SecureField("Please Enter your Password", text: $userViewModel1.password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        
                    
                    NavigationLink(destination: SignInView(LoginViewModel: LoginViewModel()), isActive: $navigateToLocation) {
                        
                    }
                    Divider()
                    Button("Sign Up") {
                       
                    action: do {
                        userViewModel1.signup()
                        navigateToLocation = true
                    }}
                    .font(.title2)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    
                   /* Button(action: {
                        userViewModel1.signup()
                                        }) {
                                            Text("Sign Up")
                                                .font(.title2)
                                                .fontWeight(.bold)
                                                .frame(maxWidth: .infinity)
                                                .padding()
                                                .background(Color.green)
                                                .foregroundColor(.white)
                                                .cornerRadius(10)
                                                .frame(width: 402, height: 50)
                                            
                                          
                                        }*/


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
                    
                    NavigationLink(destination: SignInView(LoginViewModel: LoginViewModel())){ Text("Login")
                            .font(.title3)
                            .foregroundColor(.green)
                    }
                    
                }
            }
        }
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(userViewModel1: userViewModel1())
    }
}
