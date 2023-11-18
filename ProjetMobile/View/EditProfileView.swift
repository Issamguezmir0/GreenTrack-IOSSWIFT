import SwiftUI
import Foundation
struct EditProfileView: View {
    @State private var selectedImage: Image? = nil
    @State private var newFullName = ""
    @State private var newPhoneNumber = ""
    @State private var newAddress = ""

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
                    TextField("Full Name", text: $newFullName)
                    TextField("Phone Number", text: $newPhoneNumber)
                    TextField("Address", text: $newAddress)
                }

                Section {
                    Button(action: {
                        // Implement logic to save changes
                        saveChanges()
                    }) {
                        Text("Save Changes")
                    }
                }
            }
            .navigationBarTitle("Edit Profile")
        }
    }

    // Function to save changes
    func saveChanges() {
        // Implement logic to save changes to the server or update the ViewModel
        // You can access the edited values using newPassword, newFullName, newPhoneNumber, newAddress
    }
}

struct UserProfileEditView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView()
    }
}
