import SwiftUI
import SafariServices

struct ConteView: View {
    @State private var videoFiles: [String] = []
    @State private var selectedVideoName: String?
    @State private var isDeleteMode = false
    @ObservedObject private var viewModel = VideosViewModel()

    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack {
                List {
                    ForEach(videoFiles, id: \.self) { videoName in
                        HStack {
                            Image(systemName: "play")
                                .frame(width: 80, height: 200)
                                .cornerRadius(10)

                            VStack(alignment: .leading) {
                                Text(videoName)
                                    .font(.body)
                                    .fontWeight(.bold)
                                    .foregroundColor(.primary)
                                    .lineLimit(2)
                            }

                            Spacer()

                            if isDeleteMode {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(selectedVideoName == videoName ? .blue : .gray)
                                    .onTapGesture {
                                        // Toggle selection on tap
                                        if selectedVideoName == videoName {
                                            selectedVideoName = nil
                                        } else {
                                            selectedVideoName = videoName
                                        }
                                    }
                            }
                        }
                        .onTapGesture {
                            if isDeleteMode {
                                // In delete mode, tapping on the row should toggle selection
                                if selectedVideoName == videoName {
                                    selectedVideoName = nil
                                } else {
                                    selectedVideoName = videoName
                                }
                            } else {
                                // In normal mode, tapping opens the video in Safari
                                selectedVideoName = videoName
                                openVideoInSafari()
                            }
                        }
                    }
                }
                .onAppear {
                    fetchVideoNames()
                }
            }
            
            // Delete button in the top-right corner
            Button(action: {
                isDeleteMode.toggle()
            }) {
                Text(isDeleteMode ? "Done" : "Delete")
            }
            .padding()
            .foregroundColor(.blue)
        }
    }

    func deleteVideo() {
        guard let selectedVideoName = selectedVideoName else {
            return
        }

        viewModel.deleteVideos(selectedVideoName)
    }

    func fetchVideoNames() {
        let apiUrl = URL(string: "http://localhost:8000/video/videos/name/")!

        URLSession.shared.dataTask(with: apiUrl) { (data, response, error) in
            if let error = error {
                print("Error fetching video names: \(error)")
                return
            }

            guard let data = data else {
                print("No data received while fetching video names")
                return
            }

            do {
                struct VideoNamesResponse: Decodable {
                    let videoFiles: [String]
                }

                let response = try JSONDecoder().decode(VideoNamesResponse.self, from: data)
                DispatchQueue.main.async {
                    self.videoFiles = response.videoFiles
                }
            } catch {
                print("Error decoding video names: \(error)")
            }
        }.resume()
    }


    func openVideoInSafari() {
        guard let selectedVideoName = selectedVideoName,
              let videoURL = URL(string: "http://localhost:8000/video/videos/names/\(selectedVideoName)"),
              UIApplication.shared.canOpenURL(videoURL) else {
            return
        }

        let safariViewController = SFSafariViewController(url: videoURL)
        UIApplication.shared.windows.first?.rootViewController?.present(safariViewController, animated: true, completion: nil)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ConteView()
    }
}
