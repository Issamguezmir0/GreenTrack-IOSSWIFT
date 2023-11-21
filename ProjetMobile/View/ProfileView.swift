import SwiftUI

struct ProfileView: View {
    @ObservedObject var viewModel2 = ProfileViewModel()
    @State private var userFullname : String?
    @State private var userEmail : String?
    @State private var userPhone : String?
    @State private var userImage : String?
    @ObservedObject var profileViewModel = ProfileViewModel()

    var body: some View {
        NavigationView {
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
                    .padding()

                HStack {
                                    Text("Fullname:")
                                        .font(.headline)
                                        .padding()

                                    if let userFullname = viewModel2.fullname {
                                        Text(userFullname)
                                            .font(Font.custom("Nimbus Sans L", size: 20).weight(.bold))
                                    } else {
                                        Text("Loading...")
                                            .font(Font.custom("Nimbus Sans L", size: 20).weight(.bold))
                                            .foregroundColor(.red) // Change color or add loading indicator as needed
                                    }
                                }

                HStack {
                    Text("Email :")
                        .font(.headline)
                        .padding()
                    if let userEmail = viewModel2.email {
                        Text(userEmail)
                            .font(Font.custom("Nimbus Sans L", size: 20).weight(.bold))
                    } else {
                        Text("Loading...")
                            .font(Font.custom("Nimbus Sans L", size: 20).weight(.bold))
                            .foregroundColor(.red) // Change color or add loading indicator as needed
                    }
                    
                    
                    
                    // Utilisez la valeur directement depuis le viewModel
                  
                }

            /*    HStack {
                    Text("Phone Number:")
                        .font(.headline)
                        .padding()

                    // Utilisez la valeur directement depuis le viewModel
                    Text(viewModel2.num_tel)
                } *//*.onReceive(viewModel2.$isNavigationActive) { value in
                    if value {
                        userPhone = UserDefaults.standard.object(forKey: "usernum_tel") as? String
                        
                    } }*/

                HStack(spacing: 20) {
                    VStack {
                        NavigationLink(destination: EditProfileView(viewModel: EditProfileViewModel()), isActive: $viewModel2.isNavigationActive) { }

                        ProfileButton(imageName: "pencil.circle.fill", buttonText: "Edit detail") {
                            viewModel2.isNavigationActive = true
                        }
                    }

                    VStack {
                        NavigationLink(destination: ChangePasswordView(ViewModel: ChangePassViewModel()), isActive: $viewModel2.isNavigationActive) { }

                        ProfileButton(imageName: "arrow.counterclockwise.circle.fill", buttonText: "Reset Pass") {
                            viewModel2.isNavigationActive = true
                        }
                    }

                    ProfileButton(imageName: "calendar.circle.fill", buttonText: "Event") {
                        // Action à effectuer lorsque le bouton Évènement est pressé
                    }

                    ProfileButton(imageName: "arrow.right.circle.fill", buttonText: "Logout") {
                        // Action à effectuer lorsque le bouton Logout est pressé
                    }
                }
                .padding()

                Button("Delete Account") {
                    // Ajoutez ici le code pour supprimer le compte
                }
                .font(.title2)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .onReceive(profileViewModel.$isNavigationActive) { value in
                                   if value {
                                       userFullname = UserDefaults.standard.object(forKey: "userfullname") as? String
                                       userEmail = UserDefaults.standard.object(forKey: "useremail") as? String
                                       //userPhone = UserDefaults.standard.object(forKey: "userphone") as? String

                                       print(userEmail)
                                       print(userFullname)
                                       
                                   }
                
                                   // Optionally, trigger authentication when the view appears
                                   
                               }
            .padding()
            .navigationBarTitle("Profile", displayMode: .inline)
            .onAppear {
                viewModel2.authenticateUserProfile()
            }
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
