import SwiftUI
import Foundation
struct EditProfileView: View {
    @State private var selectedImage: Image? = nil
    
    @ObservedObject var viewModel: EditProfileViewModel


    var body: some View {
        NavigationView {
            Form {
              

                Section(header: Text("Change Profile Picture")) {
                    Button(action: {
                        // Implement logic to open ImagePicker
                    }) {
                        Text("Select Profile Picture")
                    }
                    // Display the selected image
                    if let image = selectedImage {
                        image.resizable()
                            .scaledToFit()
                            .frame(height: 100)
                    }
                }

                Section(header: Text("Edit Profile Information")) {
                    TextField("Full Name", text: $viewModel.fullname)
                    TextField("Phone Number", text: $viewModel.num_tel)
                    TextField("Email Address", text: $viewModel.email)
                }

                Section {
                    Button(action: {
                        viewModel.updateUser()
                        
                    }) {
                        Text("Save Changes")
                    }
                }
            }
            .navigationBarTitle("Edit Profile")
        }
    }

   
}

struct UserProfileEditView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView(viewModel: EditProfileViewModel())
    }
}
