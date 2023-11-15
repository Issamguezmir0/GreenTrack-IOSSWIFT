//
//  ReelView.swift
//  InstaFeed
//
//  Created by Bechir Kefi on 14/11/2023.
//

import SwiftUI
import AVKit

struct ReelView: View {
    @Binding var reel: Reel
    @Binding var likedCounter: [Like]
    var size: CGSize
    var safeArea: EdgeInsets

    @State private var player: AVPlayer?
    @State private var isLiked = false
    @State private var heartAnimation = false
    
    var reels: [Reel]
    var scrollViewProxy: ScrollViewProxy?

    var body: some View {
        GeometryReader { geometry in
            let rect = geometry.frame(in: .global)
            ZStack(alignment: .bottomLeading) {
                CustomVideoPlayer(player: $player)
                    .preference(key: OffsetKey.self,value: rect)
                    .onPreferenceChange(OffsetKey.self,perform: { value in
                        playPause(value)
                    }
                    )
                    .frame(width: 500, height: 850)

                ReelDetailsView()
                    .padding(.leading, 15)
                    .padding(.trailing, 10)
                    .padding(.bottom)

    
                         }
            .onAppear {
                guard player == nil else { return }
                guard let videoURL = Bundle.main.url(forResource: reel.videoID, withExtension: "mp4") else {
                    print("Video URL not found.")
                    return
                }
                print("Initializing AVPlayer with URL: \(videoURL)")
                player = AVPlayer(url: videoURL)
            }
            .onDisappear {
                player?.pause()
                player = nil
            }
            .onTapGesture(count: 2) {
                handleDoubleTap()
            }
        }
    }
    
    func handleDoubleTap() {
           if !isLiked {
               reel.isLiked.toggle()
               likedCounter.append(Like()) // Add a like to your counter
               heartAnimation = true
           }
           isLiked.toggle()
       }

    func playPause(_ rect: CGRect) {
        // Calculate the threshold as 0.5 of the video height
        let threshold = 0.5 * size.height
        
        // Check if the scroll position is within the threshold
        if -rect.minY < threshold && rect.minY < threshold {
            player?.play()
        } else {
            player?.pause()
        }
        
        // If the scroll position is beyond the video height, seek to the beginning
        if rect.minY >= size.height {
            player?.seek(to: .zero)
            
            // Scroll to the next video
            // Assuming you have an array of reels, you can determine the next reel
            if let currentIndex = reels.firstIndex(where: { $0.id == reel.id }), currentIndex + 1 < reels.count {
                withAnimation {
                    // Scroll to the next video
                    // Assuming you have a ScrollView, you can use a ScrollViewReader to scroll
                    // Adjust the ID or identifier based on your data structure
                    scrollViewProxy?.scrollTo(reels[currentIndex + 1].id, anchor: .top)
                }
            }
        }
    }


    @ViewBuilder
    func ReelDetailsView() -> some View {
        HStack(alignment: .bottom, spacing: 10) {
            VStack(alignment: .leading, spacing: 8, content: {
                HStack(spacing: 10){
                    Image(systemName: "person.circle.fill")
                        .font(.largeTitle)
                    
                    Text(reel.authorName)
                        .font(.callout)
                        .lineLimit(1)
                }
                .foregroundColor(.white)
                
                Text("EcoTrack .... EcoTrack.... EcoTrack...")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
                    .clipped()
            })
            
            Spacer(minLength: 0)
            
            VStack(spacing:35) {
                
                Button(action: {
                    reel.isLiked.toggle()
                }) {
                    Image(systemName: reel.isLiked ? "suit.heart.fill" : "suit.heart")
                }
               // .symbolEffect(.bounce, value: reel.isLiked)
                .foregroundStyle(reel.isLiked ? .red : .white)
                
            
            
            
                Button(action: {
                    reel.isLiked.toggle()
                }) {
                    Image(systemName: "message")
                }
                
                Button(action: {
                    reel.isLiked.toggle()
                }) {
                    Image(systemName: "paperplane")
                }

                Button(action: {
                    reel.isLiked.toggle()
                }) {
                    Image(systemName: "ellipsis")
                }
                


            }
            .font(.title2)
            .foregroundStyle(.white)
            .padding(.leading, 15)
            .padding(.trailing, 70)
        }
        .padding(.leading, 15)
        .padding(.trailing, 10)
        .padding(.bottom, safeArea.bottom + 70)
        

    }
   
}





struct ReelView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

