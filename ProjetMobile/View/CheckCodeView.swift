//
//  CheckCodeView.swift
//  ProjetMobile
//
//  Created by issam guezmir on 18/11/2023.
//

import SwiftUI

struct CheckCodeView: View {
    @State private var num_tel = ""
    @State private var CodeReset = ""
    @State private var isPhoneNumberValid = true

    var body: some View {
        ZStack{
            VStack(alignment: .leading){
                
                    Text("Enter Your Phone Number :")
                    .font(.title3)
                    .foregroundColor(.green)
                    .fontWeight(.bold)
                    .frame(alignment: .leading)
                    .padding()
                
                
                    TextField("+216", text: $num_tel)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .onChange(of: num_tel, perform: { newValue in
                            isPhoneNumberValid = isValidPhoneNumber(newValue)
                        })
                    
                    if !isPhoneNumberValid {
                        Text("Invalid phone number , should start with +216")
                            .foregroundColor(.red)
                            .padding()
                    }
                      
                    Text("Code sent by SMS :")
                    .font(.title3)
                    .foregroundColor(.green)
                    .fontWeight(.bold)
                    .frame(alignment: .leading)
                    .padding()
                
                
                    TextField("XXXX", text: $CodeReset)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                
                VStack{
                    
                    Button("Send"){
                        
                    }
                    .font(.title2)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }.padding()
                
            }
            
          
        }
    }
    func isValidPhoneNumber(_ phoneNumber: String) -> Bool {
        // Check if the phoneNumber starts with "+216"
        return phoneNumber.hasPrefix("+216") && phoneNumber.count >= 5
    }
}


struct CheckCodeView_Previews: PreviewProvider {
    static var previews: some View {
        CheckCodeView()
    }
}
