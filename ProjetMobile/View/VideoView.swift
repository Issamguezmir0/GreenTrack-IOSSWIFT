//
//  VideoView.swift
//  miniTiktok
//
//  Created by Bechir Kefi on 3/11/2023.
//

import SwiftUI
import AVKit

struct VideoView: View {
    var video: Video
    @State private var player = AVPlayer()
    
    var body: some View {
        NavigationView { 
            VideoPlayer(player: player)
                .edgesIgnoringSafeArea(.all)
                .onAppear {
                    if let link = video.videoFiles.first?.link {
                        player = AVPlayer(url: URL(string: link)!)
                        player.play()
                    }
                }
        }
    }
}


struct VideoView_Previews: PreviewProvider {
    static var previews: some View {
        VideoView(video: previewVideo)
    }
}
