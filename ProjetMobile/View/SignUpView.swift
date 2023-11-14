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

    init(userViewModel1: userViewModel1) {
        self.userViewModel1 = userViewModel1
    }

    var body: some View {
        NavigationStack{
        ZStack {
            VStack(alignment: .leading) {
                Text("Create an account")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                Text("Connect with your friends today! 👋")
                    .font(.title3)
                    .foregroundColor(.gray)
                    .frame(alignment: .leading)

                Text("Full Name")
                    .font(.title3)
                    .foregroundColor(.green)
                    .frame(alignment: .leading)

                VStack {
                    TextField("Enter your fullname", text: $userViewModel1.fullname)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }

                Text("Email Address")
                    .font(.title3)
                    .foregroundColor(.green)
                    .frame(alignment: .leading)

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

                    SecureField("Please Enter your Password", text: $userViewModel1.password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                    Text("Verify password")
                        .font(.title3)
                        .foregroundColor(.green)
                        .frame(alignment: .leading)
                        .padding(.leading, -180)

                    SecureField("Please Enter your Password", text: $userViewModel1.password1)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    NavigationLink(destination: SignInView(), isActive: $navigateToLocation) {
                        
                    }
                    Button("Sign Up") {
                        self.userViewModel1.signup()
                    action: do {
                        navigateToLocation = true
                    }}
                    .font(.title2)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)

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

                        Button(action: {
                            // Action to perform when the Gmail button is pressed
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
            }
            .padding()

            VStack {
                Spacer()
                HStack {
                    Text("Already have an account ?")
                    
                    NavigationLink(destination: SignInView()){ Text("Login")
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
