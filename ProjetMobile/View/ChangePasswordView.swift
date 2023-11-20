import SwiftUI

struct ChangePasswordView: View {
    @ObservedObject var viewModel : resetPasswordViewModel
    @State private var verifyNewPassword = ""
    @State private var passwordChangeStatus: PasswordChangeStatus? = nil

    enum PasswordChangeStatus {
        case idle, changing, success, failure
    }

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Change Password")) {
                    SecureField("Current Password", text: $viewModel.newPassword)
                    SecureField("New Password", text: $viewModel.verifyPassword)
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
        // Implement logic to change the password
        // You should check if the current password is correct,
        // if the new password is valid, and if it matches the verification password.
        // Update passwordChangeStatus accordingly.

        // For illustration purposes, let's assume a simple logic here:
     
    }
}

struct ChangePasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ChangePasswordView(viewModel: resetPasswordViewModel())
    }
}
