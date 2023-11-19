import SwiftUI

//extension Image {
//    func toData() -> Data? {
//        guard let uiImage = UIImage(named: "yourImageName") else { return nil }
//              return uiImage.jpegData(compressionQuality: 1.0)
//    }
//}

struct AddChallengeView: View {
    @State private var title = ""
    @State private var description = ""
    @State private var details = ""
    @State private var location = ""
    @State private var organiser = ""
    @State private var date = Date()
    @State private var selectedImage: Image?
    @State private var showImagePicker = false
    @State private var isFree = true // Initially assuming it's a free event
    @State private var priceInDinars = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Informations")) {
                    TextField("Title", text: $title)
                    TextField("Description", text: $description)
                    TextField("Add more details..", text: $details)
                    TextField("Insert location", text: $location)
                    TextField("Who's the organizer?", text:$organiser)
                    DatePicker("Date", selection: $date, in: Date()...)
                    
                    if selectedImage != nil {
                        selectedImage?
                            .resizable()
                            .scaledToFit()
                            .frame(height: 150)
                    }
                    Button("Select image") {
                        self.showImagePicker = true
                    }
                    .sheet(isPresented: $showImagePicker) {
                        ImagePicker(selectedImage: $selectedImage, isPresented: $showImagePicker)
                    }

                    
                    Toggle("Is it a paid event?", isOn: $isFree)
                    if !isFree {
                        TextField("Price in Dinars Tunisian", text: $priceInDinars)
                    }
                }
                
                Button(action: {
                    saveEvent(with: <#Data#>)
                }) {
                    Text("Save")
                }
                
                NavigationLink(destination: ChallengeView()) {
                    Text("All events")
                }
            }
            .navigationTitle("Add new event")
        }
    }
    
    func saveEvent(with imageData: Data) {
        // Vérifiez si une image a été sélectionnée
//        guard let selectedImageData = selectedImage?.toData() else {
//            print("No image selected")
//            return
//        }
        guard let selectedImage = selectedImage else {
                 print("No image selected")
                 return
             }
             
             guard let imageData = selectedImageToData(selectedImage) else {
                 print("Failed to convert image to data")
                 return
             }
             
        // Convertissez l'URL de votre API
        guard let apiUrl = URL(string: "http://172.20.10.5:8000/challenge/events") else {
            print("Invalid URL")
            return
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd" // Ajustez ce format selon le format de date attendu par votre backend
        
        let userData: [String: Any] = [
            "title": title,
            "description": description,
            "date": dateFormatter.string(from: date),
            "location": location,
            "isFree": isFree,
            "participants": "",
            "organiser": organiser,
            "details": details,
            "priceInDinars": priceInDinars,
            "image": imageData
        ]
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: userData)
            var request = URLRequest(url: apiUrl)
            request.httpMethod = "POST"
            request.httpBody = jsonData
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                } else if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        let result = try decoder.decode(Events.self, from: data)
                        // Update the UI or perform actions based on the response
                        print("Response: \(result)")
                        
                        // Example: If you want to navigate to another view after successful response
                        DispatchQueue.main.async {
                            // Navigate to another view or perform an action here...
                            // For example, dismiss the current view
                        }
                    } catch {
                        print("Error decoding JSON: \(error.localizedDescription)")
                    }
                }
            }.resume()
        } catch {
            print("Error converting data to JSON: \(error.localizedDescription)")
        }
    }

    
    func uiImageToData(_ uiImage: UIImage) -> Data? {
           return uiImage.jpegData(compressionQuality: 1.0)
       }
    
    
    func selectedImageToData(_ selectedImage: Image) -> Data? {
        guard let uiImage = UIImage(named: "myImage") else {
            return nil
        }

        return uiImage.jpegData(compressionQuality: 1.0)
    }
    
    struct AddChallengeView_Previews: PreviewProvider {
        static var previews: some View {
            AddChallengeView()
        }
    }
    
    struct ImagePicker: UIViewControllerRepresentable {
        @Binding var selectedImage: Image?
        @Binding var isPresented: Bool
        @Environment(\.presentationMode) var presentationMode
        
        func makeUIViewController(context: Context) -> UIImagePickerController {
            let picker = UIImagePickerController()
            picker.delegate = context.coordinator
            return picker
        }
        
        func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
        
      
        
        class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
            var parent: ImagePicker

            init(_ parent: AddChallengeView) {
                self.parent = parent
            }
            
            func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
                    if let uiImage = info[.originalImage] as? UIImage {
                        if let imageData = parent.uiImageToData(uiImage) {
                            parent.selectedImage = Image(uiImage: uiImage)
                            parent.saveEvent(with: imageData)
                        }
                    }
                    parent.isPresented = false // Dismiss the ImagePicker
                }
        }
        func makeCoordinator() -> Coordinator {
            Coordinator(self)
        }
    }
}
