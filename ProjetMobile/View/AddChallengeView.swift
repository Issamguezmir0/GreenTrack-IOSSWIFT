import SwiftUI


struct AddChallengeView: View {
    @State private var title = ""
    @State private var description = ""
    @State private var details = ""
    @State private var location = ""
    @State private var organiser = ""
    @State private var date = Date()
    @State private var selectedImage: UIImage?
    @State private var showImagePicker = false
    @State private var isFree = true
    @State private var price = ""
    @State private var imageUrl :String?
    
    
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
                        Image(uiImage: selectedImage!)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 150)
                    }
                    Button("Select image") {
                        self.showImagePicker = true
                    }
                    .sheet(isPresented: $showImagePicker) {
                        ImagePicker(selectedImage: $selectedImage,imageUrl:$imageUrl)
                    }
                    
                    Toggle("Is it a free event?", isOn: $isFree)
                    if !isFree {
                        TextField("Price in Dinars Tunisian", text: $price)
                    }
                }
                
                Button(action: {
                    saveEvent()
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
    
    func saveEvent() {

        
        
       
        guard let apiUrl = URL(string: "\(AppConfig.apiUrl)/challenge/events") else {
            print("Invalid URL")
            return
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let userData: [String: Any] = [
            "title": title,
            "description": description,
            "date": dateFormatter.string(from: date),
            "location": location,
            "isFree": isFree,
            "participants": "",
            "organiser": organiser,
            "details": details,
            "price": price,
        ]
        
        do {
            var request = URLRequest(url: apiUrl)
            request.httpMethod = "POST"
            

            // Create a boundary for the multipart/form-data
                let boundary = "Boundary-\(UUID().uuidString)"
                request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

                // Prepare JSON data
             

                // Convert JSON data to Data
                let jsonBodyData = try! JSONSerialization.data(withJSONObject: userData)

                // Create the body of the request
                var requestBodyData = Data()

                // Append the JSON data to the request body
                requestBodyData.append("--\(boundary)\r\n".data(using: .utf8)!)
                requestBodyData.append("Content-Disposition: form-data; name=\"json\"\r\n\r\n".data(using: .utf8)!)
                requestBodyData.append(jsonBodyData)
                requestBodyData.append("\r\n".data(using: .utf8)!)

                // Append the image data to the request body
                requestBodyData.append("--\(boundary)\r\n".data(using: .utf8)!)
                requestBodyData.append("Content-Disposition: form-data; name=\"image\"; filename=\"image.jpg\"\r\n".data(using: .utf8)!)
                requestBodyData.append("Content-Type: image/png\r\n\r\n".data(using: .utf8)!)

                // Replace this with your image data
                let imageData = selectedImage!.pngData()

                requestBodyData.append(imageData!)
                requestBodyData.append("\r\n".data(using: .utf8)!)

                requestBodyData.append("--\(boundary)--\r\n".data(using: .utf8)!)

                // Set the request body
                request.httpBody = requestBodyData
            
         
            
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                } else if let data = data {
                    do {
                        let jsonResponse = try JSONSerialization.jsonObject(with: data, options: [])
                        print("Response: \(jsonResponse)")
                    } catch {
                        print("Error parsing JSON: \(error.localizedDescription)")
                    }
                }
            }.resume()
        } catch {
            print("Error converting data to JSON: \(error.localizedDescription)")
        }
    }

   

    
    struct AddChallengeView_Previews: PreviewProvider {
        static var previews: some View {
            AddChallengeView()
        }
    }
    
    struct ImagePicker: UIViewControllerRepresentable {
        @Binding var selectedImage: UIImage?
        @Binding var imageUrl : String?
        @Environment(\.presentationMode) var presentationMode
        
        func makeUIViewController(context: Context) -> UIImagePickerController {
            let picker = UIImagePickerController()
            picker.delegate = context.coordinator
            return picker
        }
        
        func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
        
        func makeCoordinator() -> Coordinator {
            Coordinator(self)
        }
        
        class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
            var parent: ImagePicker
            
            init(_ parent: ImagePicker) {
                self.parent = parent
            }
            
            func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
                if let uiImage = info[.originalImage] as? UIImage {
                    parent.selectedImage = uiImage
                    parent.imageUrl = info[.mediaURL] as? String
                }
                parent.presentationMode.wrappedValue.dismiss()
            }
        }
    }
}
