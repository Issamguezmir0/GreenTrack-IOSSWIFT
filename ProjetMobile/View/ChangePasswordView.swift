import SwiftUI

struct ChangePasswordView: View {
  //  @ObservedObject var viewModel : resetPasswordViewModel
    @State private var verifyNewPassword = ""
    @State private var passwordChangeStatus: PasswordChangeStatus? = nil
@State private var currentPassword  = ""
    @State private var newPasswordPassword  = ""
    @ObservedObject var ViewModel: ChangePassViewModel


    enum PasswordChangeStatus {
        case idle, changing, success, failure
    }

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Change Password")) {
                    SecureField("Current Password", text: $ViewModel.currentPassword)
                    SecureField("New Password", text: $ViewModel.newPassword)
                }

                Section {
                    Button(action: {
                        // Implement logic to change password
                        changePassword()
                    }) {
                        Text("Change Password")
                    }
                }

                if let status = passwordChangeStatus {
                    Section {
                        switch status {
                        case .changing:
                            Text("Changing password...")
                        case .success:
                            Text("Password changed successfully!")
                                .foregroundColor(.green)
                        case .failure:
                            Text("Failed to change password.")
                                .foregroundColor(.red)
                        default:
                            EmptyView()
                        }
                    }
                }
            }
            .navigationBarTitle("Change Password")
        }
    }

    func changePassword() {
        ViewModel.send()
     
    }
}

struct ChangePasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ChangePasswordView(ViewModel: ChangePassViewModel())
    }
}
