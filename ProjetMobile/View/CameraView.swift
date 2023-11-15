//
//  CameraView.swift
//  ProjetMobile
//
//  Created by Bechir Kefi on 14/11/2023.
//

import SwiftUI
import AVFoundation

struct CameraView: View {
    @StateObject var cameraModel = CameraModel()

    var body: some View {
        CameraPreview(camera: cameraModel)
            .onAppear(perform: cameraModel.checkPermission)
            .overlay(
                Button(action: {
                    if cameraModel.isRecording {
                        cameraModel.stopRecording()
                    } else {
                        cameraModel.startRecording()
                    }
                    cameraModel.isRecording.toggle()
                }, label: {
                    Image(systemName: cameraModel.isRecording ? "stop.circle" : "circle.fill.record")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.red)
                        .padding()
                })
                .padding(.bottom, 20),
                alignment: .bottom
            )
    }
}

// MARK: Camera View Model
class CameraModel: NSObject,ObservableObject, AVCaptureFileOutputRecordingDelegate {
//@Published var isTaken = false
    
    @Published var session = AVCaptureSession()
    
    @Published var alert = false
    
    @Published var output: AVCaptureMovieFileOutput?
    @Published var preview: AVCaptureVideoPreviewLayer!
 

      @Published var isRecording = false
      @Published var videoURL: URL?
    @Published var recordingTime: Int = 0
    private var timer: Timer?
 //   @Published var isSaved = false
    
  //  @Published var picData = Data(count: 0)
    
    func checkPermission() {
         switch AVCaptureDevice.authorizationStatus(for: .video) {
         case .authorized:
             setUp()
             return
         case .notDetermined:
             AVCaptureDevice.requestAccess(for: .video) { status in
                 if status {
                     self.setUp()
                 }
             }
         case .denied:
             self.alert.toggle()
             return
         default:
             return
         }
     }
    func setUp() {
          self.session.beginConfiguration()

          if let device = AVCaptureDevice.default(.builtInDualCamera, for: .video, position: .back) {
              do {
                  let input = try AVCaptureDeviceInput(device: device)
                  if self.session.canAddInput(input) {
                      self.session.addInput(input)
                  } else {
                      print("Unable to add input to session.")
                  }
              } catch {
                  print("Error creating AVCaptureDeviceInput: \(error.localizedDescription)")
              }

              let movieOutput = AVCaptureMovieFileOutput()
              if self.session.canAddOutput(movieOutput) {
                  self.session.addOutput(movieOutput)

                  if let connection = movieOutput.connection(with: .video) {
                      if connection.isVideoStabilizationSupported {
                          connection.preferredVideoStabilizationMode = .auto
                      }
                  }

                  self.output = movieOutput
              } else {
                  print("Unable to add movie output to session.")
              }
          } else {
              print("AVCaptureDevice.default returned nil. Using a different camera configuration.")

              if let defaultDevice = AVCaptureDevice.default(for: .video) {
                  do {
                      let input = try AVCaptureDeviceInput(device: defaultDevice)
                      if self.session.canAddInput(input) {
                          self.session.addInput(input)
                      } else {
                          print("Unable to add input to session.")
                      }
                  } catch {
                      print("Error creating AVCaptureDeviceInput: \(error.localizedDescription)")
                  }

                  let movieOutput = AVCaptureMovieFileOutput()
                  if self.session.canAddOutput(movieOutput) {
                      self.session.addOutput(movieOutput)

                      if let connection = movieOutput.connection(with: .video) {
                          if connection.isVideoStabilizationSupported {
                              connection.preferredVideoStabilizationMode = .auto
                          }
                      }

                      self.output = movieOutput
                  } else {
                      print("Unable to add movie output to session.")
                  }
              } else {
                  print("Default camera configuration not available.")
              }
          }

          self.session.commitConfiguration()
      }

    func startRecording() {
          guard let movieOutput = self.output as? AVCaptureMovieFileOutput else { return }

          let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
          let fileName = UUID().uuidString + ".mov"
          let fileURL = documentsURL.appendingPathComponent(fileName)

          movieOutput.startRecording(to: fileURL, recordingDelegate: self)
          startTimer()
      }

      func stopRecording() {
          guard let movieOutput = self.output as? AVCaptureMovieFileOutput else { return }
          movieOutput.stopRecording()
          stopTimer()
      }

      func startTimer() {
          timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
              self.recordingTime += 1
          }
      }

      func stopTimer() {
          timer?.invalidate()
          timer = nil
          recordingTime = 0
      }
    func saveVideo() {
        guard let videoURL = self.videoURL else {
            print("No video to save.")
            return
        }

        let activityViewController = UIActivityViewController(activityItems: [videoURL], applicationActivities: nil)

        // For iPad support
        if let popoverController = activityViewController.popoverPresentationController {
            popoverController.sourceView = UIApplication.shared.windows.first
        }

        UIApplication.shared.windows.first?.rootViewController?.present(activityViewController, animated: true) {
            // Completion handler after the activity view controller is presented
            print("Video saved successfully")
        }
    }

    
    func fileOutput(_ output: AVCaptureFileOutput, didFinishRecordingTo outputFileURL: URL, from connections: [AVCaptureConnection], error: Error?) {
        if let error = error {
            print("Error recording video: \(error.localizedDescription)")
        } else {
            self.videoURL = outputFileURL
            print("Video recorded successfully at \(outputFileURL)")
            saveVideo() // Save the recorded video
        }
        self.isRecording = false
    }

    
//    func takePic(){
//        DispatchQueue.global(qos: .background).async {
//            self.output.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
//            self.session.stopRunning()
//
//            DispatchQueue.main.async{
//                withAnimation{self.isTaken.toggle()}
//            }
//        }
//    }
//
//    func reTake(){
//        DispatchQueue.global(qos: .background).async{
//            self.session.startRunning()
//
//            DispatchQueue.main.async {
//                withAnimation{self.isTaken.toggle()}
//
//                self.isSaved = false
//            }
//        }
//    }
    
//    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
//        if let error = error {
//              print("Error capturing photo: \(error.localizedDescription)")
//              return
//          }
//        if error != nil {
//            return
//        }
//        print("pic taken ...")
//
//        guard let imageData = photo.fileDataRepresentation() else{return}
//
//        self.picData = imageData
//    }
//
//    func savePic() {
//        if let image = UIImage(data: self.picData) {
//            guard let imageData = image.jpegData(compressionQuality: 1.0) else { return }
//
//            let temporaryDirectoryURL = FileManager.default.temporaryDirectory
//            let temporaryFileURL = temporaryDirectoryURL.appendingPathComponent("tempImage.jpg")
//
//            do {
//                try imageData.write(to: temporaryFileURL)
//            } catch {
//                print("Error writing temporary file: \(error.localizedDescription)")
//                return
//            }
//
//            let activityViewController = UIActivityViewController(activityItems: [temporaryFileURL], applicationActivities: nil)
//
//            // For iPad support
//            if let popoverController = activityViewController.popoverPresentationController {
//                popoverController.sourceView = UIApplication.shared.windows.first
//            }
//
//            UIApplication.shared.windows.first?.rootViewController?.present(activityViewController, animated: true) {
//                // Completion handler after the activity view controller is presented
//                self.isSaved = true
//                print("Image saved successfully")
//            }
//        } else {
//            print("Error: Unable to create UIImage from picData.")
//        }
//    }


}

//struct CameraPreview: UIViewRepresentable{
//    @ObservedObject var camera: CameraModel
//    func makeUIView(context: Context) ->  UIView {
//        let view = UIView(frame: UIScreen.main.bounds)
//
//        camera.preview = AVCaptureVideoPreviewLayer(session: camera.session)
//        camera.preview.frame = view.frame
//
//        camera.preview.videoGravity = .resizeAspectFill
//        view.layer.addSublayer(camera.preview)
//
//        camera.session.startRunning()
//
//        return view
//
//    }
//    func updateUIView(_ uiView: UIView, context: Context) {
//
//    }
//}

struct CameraPreview: UIViewRepresentable {
    @ObservedObject var camera: CameraModel

    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: UIScreen.main.bounds)

        camera.preview = AVCaptureVideoPreviewLayer(session: camera.session)
        camera.preview.frame = view.frame

        camera.preview.videoGravity = .resizeAspectFill
        view.layer.addSublayer(camera.preview)

        camera.session.startRunning()

        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {}
}

struct CameraView_Previews: PreviewProvider {
    static var previews: some View {
        CameraView()
    }
}
