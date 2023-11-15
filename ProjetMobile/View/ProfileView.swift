import SwiftUI

struct ProfileView: View {
    @State private var isEditing = false
    @State private var description = ""
    @State private var firstname = ""
    @State private var lastname = ""
    @State private var datebirth = ""
    @State private var phone = ""
    @State private var dateOfBirth = Date()
    @State private var dateOfBirthText = ""
    
    var body: some View {
        VStack{
            Spacer(minLength: 400)
            ZStack{ RoundedRectangle(cornerRadius: 50).fill(Color(red: 0.19,green: 0.71,blue:0.29)).frame(height: 9000)
                ZStack{
                    RoundedRectangle(cornerRadius: 50).fill(Color(red: 1,green: 1,blue:1)).frame(height: 700)
                    VStack{
                        Circle()
                            .frame(width: 200,height: 200)
                            .overlay(
                                Image("profile 1")
                                    .resizable()
                                    .aspectRatio( contentMode: .fit)
                                    .frame(width: 195,height: 200)
                                    .clipShape(Circle())
                            )
                        
                        Text("Fullname")
                        
                    }.offset(y:-340)
                    
                    
                    Text("Account Details :")
                        .font(Font.custom("Inter", size: 16).weight(.semibold))
                        .lineSpacing(14)
                        .foregroundColor(.black)
                        .offset(x: -130, y: -210)
                        .fontWeight(.bold)
                    
                    VStack{
                        Text("      Fullname")
                            .font(Font.custom("Inter", size: 16).weight(.semibold))
                            .lineSpacing(14)
                            .foregroundColor(.black)
                            .offset(x: -160, y: -160)
                            .fontWeight(.bold)
                        
                        Text("email")
                            .font(Font.custom("Inter", size: 16).weight(.semibold))
                            .lineSpacing(14)
                            .foregroundColor(.black)
                            .offset(x: -160, y: -160)
                            .fontWeight(.bold)
                        Text("          Date of birth")
                            .font(Font.custom("Inter", size: 16).weight(.semibold))
                            .lineSpacing(14)
                            .foregroundColor(.black)
                            .offset(x: -160, y: -160)
                            .fontWeight(.bold)
                    }
                    
                    
                    
                    
                    
                }
            }
        }
    }
    
    struct ProfileView_Previews: PreviewProvider {
        static var previews: some View {
            ProfileView()
        }
    }
}
