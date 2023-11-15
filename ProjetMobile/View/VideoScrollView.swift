//
//  VideoScrollView.swift
//  VideoScroll
//
//  Created by Bechir Kefi on 7/11/2023.
//

import SwiftUI
import AVKit



    struct contenttView: View{
        
        @State private var activeView: String = "Home"
          let size: CGSize
          let safeArea: EdgeInsets
          
          init() {
              // Initialize size and safeArea here based on your requirements
              self.size = CGSize(width: 100, height: 300)  // Replace with your actual size
              self.safeArea = EdgeInsets()  // Replace with your actual safeAreaInsets
          }
          
          var body: some View {
              ZStack {
                  if activeView == "Home" {
                      Feed(size: size, safeArea: safeArea)
                          .background(Color.clear)
                  } else if activeView == "HomeCam" {
                      HomeCam()
                          .background(Color.clear)
                  } else if activeView == "VideoHome" {
                      VideoHomeView() // Add the VideoHomeView here
                          .background(Color.clear)
                  }
                  
                  VStack {
                      HStack {
                          Spacer()
                          
                          Button(action: {
                              activeView = "Home"
                          }) {
                              Image(systemName: "film")
                                  .padding()
                                  .background(Color.clear)
                                  .foregroundColor(activeView == "Home" ? .green : .white) // Highlight if active
                          }
                          
                          Spacer()
                          
                          Button(action: {
                              activeView = "HomeCam"
                          }) {
                              Image(systemName: "camera")
                                  .padding()
                                  .background(Color.clear)
                                  .foregroundColor(activeView == "HomeCam" ? .green : .white) // Highlight if active
                          }
                          
                          Spacer()
                          
                          Button(action: {
                              activeView = "VideoHome"
                          }) {
                              Image(systemName: "video")
                                  .padding()
                                  .background(Color.clear)
                                  .foregroundColor(activeView == "VideoHome" ? .green : .white) // Highlight if active
                          }
                          
                          Spacer()
                          
                          // Add more buttons for additional views if needed
                      }
                      .padding()
                      .background(Color.white.opacity(0)) // Set the background of the button container
                      
                      Spacer()
                  }
              }
          }
//        @Binding var data: [Videosc]
//        @Binding var currentVideoIndex: Int
//        @ObservedObject var viewModel: HomeVideoViewModel
//        @State private var currentView: ContentViewType = .playerScrollView
//
//        enum ContentViewType {
//            case playerScrollView
//            case videoScrollView
//        }
//        var body: some View {
//
//            ZStack {
//                if currentView == .playerScrollView {
//                    PlayerScrollView(viewModel: HomeVideoViewModel(), data: $viewModel.data)
//                } else {
//                    VideoHomeView()
//                }
//
//
//                VStack {
//                    HStack {
//                        Rectangle()
//                            .frame(width: 210, height: 44)
//                            .foregroundColor(Color("AccentColor"))
//                            .cornerRadius(10)
//                            .shadow(radius: 3)
//                            .overlay(
//                                HStack {
//                                    Spacer()
//                                    Button(action: {
//                                        currentView = .playerScrollView
//                                    }) {
//                                        Text("For You")
//                                            .font(currentView == .playerScrollView ? .headline : .body)
//                                            .foregroundColor(Color.white)
//
//                                    }
//                                    Spacer()
//                                    Text("|")
//                                        .font(.body)
//                                        .foregroundColor(Color.white)
//                                    Spacer()
//                                    Button(action: {
//                                        currentView = .videoScrollView
//                                    }) {
//                                        Text("Following")
//                                            .font(currentView == .videoScrollView ? .headline : .body)
//                                            .foregroundColor(Color.white)
//                                    }
//                                    Spacer()
//                                }
//                            )
//                    }
//                    .padding(EdgeInsets(top: 60, leading: 0, bottom: 0, trailing: 0))
//                    Spacer()
//                }
//            }
//            .background(Color.black.edgesIgnoringSafeArea(.all))
//            .edgesIgnoringSafeArea(.all)
//            .onAppear {
//                viewModel.playVideo()
//            }
//        }
    }


struct PlayerView: View {
    @Binding var data: [Videosc]
    @Binding var currentVideoIndex: Int
    @ObservedObject var viewModel: HomeVideoViewModel
    @State private var currentView: ContentViewType = .playerScrollView

   enum ContentViewType {
       case playerScrollView
        case videoScrollView
   }

    var body: some View {
        
    
        VStack(spacing: 0) {
            ForEach(0..<data.count) { i in
                ZStack {
                    Player(player: data[i].player)
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                        .offset(y: -5)

                    if data[i].replay {
                        Button(action: {
                            data[i].replay = false
                            data[i].player.seek(to: .zero)
                            data[i].player.play()
                        }) {
                            Image(systemName: "goforward")
                                .resizable()
                                .frame(width: 55, height: 60)
                                .foregroundColor(.white)
                        }
                    }
                }
            }
        }
    }
}

struct Player : UIViewControllerRepresentable {
    
    var player : AVPlayer
    
    func makeUIViewController(context: Context) -> AVPlayerViewController{
        
        let view = AVPlayerViewController()
        view.player = player
        view.showsPlaybackControls = false
        view.videoGravity = .resizeAspectFill
        return view
    }
    
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
        
        
    }
}
class Host : UIHostingController<ContentView>{
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        
        return .lightContent
    }
}

struct PlayerScrollView : UIViewRepresentable {
    @ObservedObject var viewModel: HomeVideoViewModel

    
    func makeCoordinator() -> Coordinator {
        
        return PlayerScrollView.Coordinator(parent1: self)
    }
    
    @Binding var data : [Videosc]
    
    
    func makeUIView(context: Context) -> UIScrollView{
        
        let view = UIScrollView()
        
        let childView = UIHostingController(rootView: PlayerView(data: $viewModel.data, currentVideoIndex: $viewModel.currentVideoIndex, viewModel: viewModel))

        // each children occupies one full screen so height = count * height of screen...
        
        childView.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * CGFloat((data.count)))
        
        // same here...
        
        view.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * CGFloat((data.count)))
        
        view.addSubview(childView.view)
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        
        // to ignore safe area...
        view.contentInsetAdjustmentBehavior = .never
        view.isPagingEnabled = true
        view.delegate = context.coordinator
        
        return view
    }
    
    func updateUIView(_ uiView: UIScrollView, context: Context) {
        
        // to dynamically update height based on data...
        
        uiView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * CGFloat((data.count)))
        
        for i in 0..<uiView.subviews.count{
            
            uiView.subviews[i].frame = CGRect(x: 0, y: 0,width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * CGFloat((data.count)))
        }
    }
    
    class Coordinator : NSObject,UIScrollViewDelegate{
        
        var parent : PlayerScrollView
        var index = 0
        
        init(parent1 : PlayerScrollView) {
            
            parent = parent1
        }
        
        func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            
            let currenrindex = Int(scrollView.contentOffset.y / UIScreen.main.bounds.height)
            
            if index != currenrindex{
                
                index = currenrindex
                
                for i in 0..<parent.data.count{
                    
                    // pausing all other videos...
                    parent.data[i].player.seek(to: .zero)
                    parent.data[i].player.pause()
                }
                
                // playing next video...
                
                parent.data[index].player.play()
                
                parent.data[index].player.actionAtItemEnd = .none
                
                NotificationCenter.default.addObserver(forName: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: parent.data[index].player.currentItem, queue: .main) { (_) in
                    
                    // notification to identify at the end of the video...
                    
                    // enabling replay button....
                    self.parent.data[self.index].replay = true
                }
            }
        }
    }
}
    

struct VideoHomeView: View {
    @ObservedObject private var viewModel = VideosViewModel()
    @State private var showSheet = false
    @State private var player: AVPlayer?

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(viewModel.videos) { video in
                        VideoCardView(video: video, player: $player, viewModel: viewModel)
                            .frame(maxWidth: .infinity)
                    }
                }
                .padding(16)
            }
       
        }
        .overlay(
            Button(action: {
                showSheet = true
            }) {
                Image(systemName: "plus")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .padding()
                    .background(Color("AccentColor"))
                    .foregroundColor(.white)
                    .cornerRadius(30)
                    .shadow(radius: 3)
            }
            .padding()
            , alignment: .bottomTrailing
        )
        .sheet(isPresented: $showSheet) {
            VideoSheetView(player: $player, showError: $viewModel.showError) { title, url, _ in
                viewModel.postVideo(video: VideoPlayers(title: title, url: url))
                showSheet = false
            }
        }
        .alert(isPresented: $viewModel.showError) {
            Alert(title: Text("Failed to load"), dismissButton: .default(Text("OK"))
            )
        }
        .onAppear {
            viewModel.getVideos()
        }
    }
}
struct VideoCardView: View {
    let video: VideoPlayers
    @Binding var player: AVPlayer?
    @ObservedObject var viewModel: VideosViewModel
    @State private var isEditing = false

    var body: some View {
        ZStack {
            VideoPlayer(player: player)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .cornerRadius(0) // No corner radius to fill the screen
                .onAppear {
                    if let videoURL = URL(string: video.url ?? "") {
                        self.player = AVPlayer(url: videoURL)
                    }
                }
            
            VStack {
                Spacer()
                HStack {
                    Text("\(video.title ?? "")")
                        .font(.title) // Use a larger font
                        .foregroundColor(.white)
                        .shadow(radius: 20)
                }
            }

            Image(systemName: "play.fill")
                .foregroundColor(.white)
                .font(.system(size: 20)) // Larger play button
                .padding()
                .background(.ultraThinMaterial)
                .cornerRadius(50)
        }
        .background(Color.black) // Background color for the video
        .frame(width: 500, height: 800) // Fill the available space
        .onTapGesture {
            // Handle tapping the card
        }
        .contextMenu {
            Button(action: {
                // Add delete video action here
                viewModel.deleteVideo(video.id!)
            }) {
                Label("Delete", systemImage: "trash")
            }
            Button(action: {
                // Show the edit sheet when "Update" is selected
                isEditing = true
            }) {
                Label("Update", systemImage: "pencil")
            }
        }
        .sheet(isPresented: $isEditing) {
            VideoSheetView(
                video: video,
                player: $player,
                showError: $viewModel.showError,
                onSave: { title, url, action in
                    // Perform your update action (patchVideo) here
                    viewModel.patchVideo(video: VideoPlayers(id: video.id, title: title, url: url))
                    action()
                }
            )
        }
    }
}


struct VideoSheetView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding private var showError: Bool
    @State private var title: String
    @State private var url: String
    @Binding private var player: AVPlayer?
    private let onSave: (String, String, DismissAction) -> Void

    init(video: VideoPlayers, player: Binding<AVPlayer?>, showError: Binding<Bool>, onSave: @escaping (String, String, DismissAction) -> Void) {
        self._showError = showError
        self._title = State(initialValue: video.title ?? "")
        self._url = State(initialValue: video.url ?? "")
        self._player = player
        self.onSave = onSave
    }

    init(player: Binding<AVPlayer?>, showError: Binding<Bool>, onSave: @escaping (String, String, DismissAction) -> Void) {
        self._showError = showError
        self._title = State(initialValue: "")
        self._url = State(initialValue: "")
        self._player = player
        self.onSave = onSave
    }

    var body: some View {
        Form {
            TextField("Title", text: $title)
            TextField("URL", text: $url)
        }

        Button("Save") {
            onSave(title, url, dismiss)
            if let videoURL = URL(string: url) {
                self.player = AVPlayer(url: videoURL)
            }
        }
        .font(.system(size: 20, weight: .bold))
        .frame(width: 200, height: 48)
        .background(Color.yellow)
        .foregroundColor(Color.black)
        .cornerRadius(16)
        .padding()

        if showError {
            Text("Error occurred while saving.")
                .foregroundColor(.red)
        }
    }
}


//
//struct VideoScrollView_Previews: PreviewProvider {
//    static var previews: some View {
//        contenttView(viewModel: HomeVideoViewModel())
//    }
//}

struct contenttViewProvider_Previews: PreviewProvider {
    static var previews: some View {
        contenttView()
    }
}
