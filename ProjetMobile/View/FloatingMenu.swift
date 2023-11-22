//
//  FloatingMenu.swift
//  ProjetMobile
//
//  Created by Bechir Kefi on 21/11/2023.
//

import SwiftUI
import MobileCoreServices // Import MobileCoreServices for the video picker

struct FloatingMenu: View {
    @State var showMenuItems = false
    @State var isShowingVideoPicker = false
    
    @State var uploadSuccess = false
    @State var videoLink: String?

    var body: some View {
        VStack {
            Spacer()
            HStack {
                ForEach(0..<2) { index in
                    MenuItem(icon: iconForIndex(index)) {
                        if iconForIndex(index) == "camera.fill" {
                            print("Action for camera.fill")
                            HomeCam()
                        } else if iconForIndex(index) == "photo.on.rectangle" {
                            print("Action for photo.on.rectangle")
                            isShowingVideoPicker.toggle()
                        }
                    }
                    .offset(
                        x: showMenuItems ? 10 * CGFloat(cos(angleForIndex(index))) : 0,
                        y: showMenuItems ? -100 * CGFloat(sin(angleForIndex(index))) : 0
                    )
                    .opacity(showMenuItems ? 1 : 0)
                    .animation(.easeInOut)
                }
                Button(action: {
                    withAnimation {
                        self.showMenuItems.toggle()
                    }
                }) {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .foregroundColor(.green)
                        .shadow(color: .gray, radius: 0.2, x: 1, y: 1)
                }
                .sheet(isPresented: $isShowingVideoPicker) {
                    // Show the video picker when isShowingVideoPicker is true
                    VideoPicker { videoURL in
                        uploadVideo(fileURL: videoURL)
                        isShowingVideoPicker.toggle() // Dismiss picker after selection
                    }
                }
            }
            if uploadSuccess, let videoLink = videoLink {
                  Text("Video uploaded successfully!")
                  Text("Link: \(videoLink)")
                      .foregroundColor(.blue)
                      .onTapGesture {
                          // Open the uploaded video link
                          guard let url = URL(string: videoLink) else { return }
                          UIApplication.shared.open(url)
                      }
              }
        }
     
    }

    func uploadVideo(fileURL: URL) {
        guard let videoData = try? Data(contentsOf: fileURL) else {
            print("Failed to get video data")
            return
        }
        
        let url = URL(string: "http://localhost:8000/video/add")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let boundary = "Boundary-\(UUID().uuidString)"
        let contentType = "multipart/form-data; boundary=\(boundary)"
        request.setValue(contentType, forHTTPHeaderField: "Content-Type")
        
        let carbonPrefix = "carbon"
        let filename = "\(carbonPrefix)_\(UUID().uuidString).mp4"
        
        var body = Data()
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"videoFile\"; filename=\"\(filename)\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: video/mp4\r\n\r\n".data(using: .utf8)!)
        body.append(videoData)
        body.append("\r\n".data(using: .utf8)!)
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        
        request.httpBody = body
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                return
            }
            // Handle response from the server
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 { // Assuming 200 is success
                    print("Video uploaded successfully!")
                    if let data = data, let responseData = String(data: data, encoding: .utf8) {
                        DispatchQueue.main.async {
                            videoLink = responseData // Update the uploaded video link
                            uploadSuccess = true // Set the success flag
                        }
                    }
                } else {
                    print("Video upload failed with status code: \(httpResponse.statusCode)")
                }
            }
        }
        task.resume()
    }


    // Rest of your functions and structs remain unchanged...
}

struct VideoPicker: UIViewControllerRepresentable {
    let onPicked: (URL) -> Void

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .savedPhotosAlbum
        picker.mediaTypes = [kUTTypeMovie as String]
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(onPicked: onPicked)
    }

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let onPicked: (URL) -> Void

        init(onPicked: @escaping (URL) -> Void) {
            self.onPicked = onPicked
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let videoURL = info[.mediaURL] as? URL {
                onPicked(videoURL)
            }
            // Dismiss the picker after selecting the video
            picker.dismiss(animated: true, completion: nil)
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            // Dismiss the picker if the cancel button is tapped
            picker.dismiss(animated: true, completion: nil)
        }
    }
}


    func angleForIndex(_ index: Int) -> Double {
        let totalItems = 2
        let indexAdjustment = Double(index) + 1
        return 120 * indexAdjustment
    }

    func iconForIndex(_ index: Int) -> String {
        switch index {
        case 0:
            return "camera.fill"
        case 1:
            return "photo.on.rectangle"
        default:
            return ""
        }
    }



struct FloatingMenu_Previews: PreviewProvider {
    static var previews: some View {
        FloatingMenu()
    }
}

struct MenuItem: View {
    var icon: String
    var action: () -> Void // Define an action closure

    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(.green)
                .frame(width: 55, height: 55)
            Image(systemName: icon)
                .imageScale(.large)
                .foregroundColor(.white)
        }
        .shadow(color: .gray, radius: 0.2, x: 1, y: 1)
        .onTapGesture {
            // Call the action closure when tapped
            action()
        }
    }
}
