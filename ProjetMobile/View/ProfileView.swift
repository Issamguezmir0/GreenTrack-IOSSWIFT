import SwiftUI

struct ProfileView: View {
    @State private var navigateToLocation = false

    var body: some View {
        NavigationStack{
            VStack {
                Image("issam")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    .overlay(
                        Circle().stroke(Color.white, lineWidth: 4)
                    )
                    .shadow(radius: 10)
                    .padding( )
                
                HStack{
                    Text("Full Name :")
                        .font(.headline)
                        .padding()
                    
                    Text("Issam Guezmir")
                    
                }
                HStack{
                    
                    Text("Email :")
                        .font(.headline)
                        .padding()
                    
                    Text("guezmir.issam@esprit.tn")
                }
                HStack{
                    Text("Phone Number:")
                        .font(.headline)
                        .padding()
                    
                    Text("+21658257761")
                }
                
                
                
                
                
                HStack(spacing: 20) {
                    
                    VStack {
                        NavigationLink( destination: EditProfileView(), isActive: $navigateToLocation){
                            
                        }
                        ProfileButton(imageName: "pencil.circle.fill", buttonText: "Edit detail") {
                            action : do {
                                navigateToLocation = true
                            }                        }
                    }
                    VStack{
                        NavigationLink( destination: ChangePasswordView(), isActive: $navigateToLocation){
                            
                        }
                        ProfileButton(imageName: "arrow.counterclockwise.circle.fill", buttonText: "Reset Pass") {
                            action : do {
                                navigateToLocation = true
                            }                        }
                    }
                    
                    ProfileButton(imageName: "calendar.circle.fill", buttonText: "Event") {
                        // Action to perform when Évènement button is pressed
                    }
                    
                    ProfileButton(imageName: "arrow.right.circle.fill", buttonText: "Logout") {
                        // Action to perform when Logout button is pressed
                    }
                }
                .padding()
                Button("Delete Account") {
                    // Ajoutez ici le code pour changer le mot de passe
                }
                .font(.title2)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .padding()
            .navigationBarTitle("Profile", displayMode: .inline)
        }
        }
}

struct ProfileButton: View {
    var imageName: String
    var buttonText: String
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack {
                Image(systemName: imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40, height: 40)
                Text(buttonText)
                    .font(.caption)
                    .foregroundColor(.black)
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.green)
        .foregroundColor(.white)
        .cornerRadius(10)
        .shadow(radius: 5)
        
    }
    
}



struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
