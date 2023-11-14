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
        VStack {
            Image("profile 1")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 120, height: 120)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.green, lineWidth: 4))
                .shadow(radius: 10)
                .padding()

            Text("Username")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.green)

            if isEditing {
                TextField("Edit your description", text: $description)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .foregroundColor(.green)
                TextField("First Name", text: $firstname)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .foregroundColor(.green)
                TextField("Last Name", text: $lastname)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .foregroundColor(.green)
                TextField("Email Address", text: $datebirth)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .foregroundColor(.green)
                TextField("Phone Number", text: $phone)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .foregroundColor(.green)
            } else {
           
                Text("First Name")
                    .font(.title3)
                    .foregroundColor(.gray)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).stroke(Color.green, lineWidth: 2))
                        .cornerRadius(10)
                Text("Last Name")
                    .font(.title3)
                    .foregroundColor(.gray)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).stroke(Color.green, lineWidth: 2))
                        .cornerRadius(10)
                Text("Date of Birth")
                    .font(.title3)
                    .foregroundColor(.gray)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).stroke(Color.green, lineWidth: 2))
                        .cornerRadius(10)
                Text("Phone Number")
                    .font(.title3)
                    .foregroundColor(.gray)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).stroke(Color.green, lineWidth: 2))
                        .cornerRadius(10)
            }
                

            if isEditing {
                DatePicker("Date of Birth", selection: $dateOfBirth, displayedComponents: .date)
                    .datePickerStyle(DefaultDatePickerStyle())
                    .padding()
                    .foregroundColor(.green)
            } else {
                Text("Date of Birth \(dateOfBirthText)")
                    .font(.title3)
                    .foregroundColor(.gray)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).stroke(Color.green, lineWidth: 2))
                        .cornerRadius(10)
            }

            Button(action: {
                isEditing.toggle()
            }) {
                Text(isEditing ? "Save" : "Edit Profile")
                    .font(.title2)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding()
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .edgesIgnoringSafeArea(.all)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
