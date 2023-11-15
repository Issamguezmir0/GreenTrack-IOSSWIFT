//
//  TestManarView.swift
//  ProjetMobile
//
//  Created by Mac mini 8 on 15/11/2023.
//

import SwiftUI

struct TestManarView: View {
    
        @State private var showStory = false
        @State private var offsetY: CGFloat = 0
        @State private var scale: CGFloat = 1
        @State private var showBarrier = false
        @State private var opacity: Double = 1
        @State private var selectedIndex = 0
       
        @StateObject private var viewModel = HomeViewModel()

        @Namespace private var storyNamespace
        @Namespace private var thumbNamespace
       
        private let storyOpeningDuration = 0.2
       
        private let deviceHeight = UIScreen.main.bounds.height

        var body: some View {
            ZStack {
                NavigationView {
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 16) {
                            StoriesThumbView(
                                showStory: $showStory,
                                showBarrier: $showBarrier,
                                selectedIndex: $selectedIndex,
                                storyNamespace: storyNamespace,
                                thumbNamespace: thumbNamespace,
                                duration: storyOpeningDuration
                            )
                           
                            ForEach(viewModel.homes) { home in
                                HomePlayerView(home: home)
                            }
                        }
                        .padding()
                    }
                    .navigationTitle("Articles")
                    .navigationBarTitleDisplayMode(.inline)
                }

                if showBarrier {
                    Rectangle()
                        .foregroundColor(.black.opacity(opacity))
                        .ignoresSafeArea()
                }
               
                ForEach(1..<11) { index in
                    if selectedIndex == index {
                        StoryView(
                            showStory: $showStory,
                            storyNamespace: storyNamespace,
                            thumbNamespace: thumbNamespace,
                            index: index
                        )
                        .offset(y: offsetY)
                        .scaleEffect(scale)
                        .gesture(
                            DragGesture()
                                .onChanged(onDrag)
                                .onEnded(onDragEnd)
                        )
                    }
                }
            }
            .onAppear {
                viewModel.getHomes()
            }
        }
       
        private func onDrag(_ value: DragGesture.Value) {
            let dy = value.translation.height
            if dy >= 0.0 {
                offsetY = dy / 2
                scale = 1 - ((dy / deviceHeight) / 10)
                opacity = 1 - dy / deviceHeight
            }
        }

        private func onDragEnd(_ value: DragGesture.Value) {
            let dy = value.translation.height
            if dy >= 0.0 {
                if dy <= deviceHeight / 2 {
                    withAnimation {
                        offsetY = 0.0
                        scale = 1.0
                        opacity = 1.0
                    }
                } else {
                    showBarrier.toggle()
                    withAnimation(.easeIn(duration: 0.4)) {
                        showStory.toggle()
                    }
                    offsetY = 0.0
                    scale = 1.0
                    opacity = 1.0
                }
            }
        }
    

    struct HomePlayerView: View {
        var home: HomePlayers
       
        var body: some View {
            VStack(alignment: .leading, spacing: 20) {
                Text(home.DescripitionArticle)
                    .font(.headline)
                Text("ID: \(home.id), User ID: \(home.idUser)")
                    .font(.subheadline)
                    .foregroundColor(.gray)

                HStack {
                    Button(action: {
                        // Implement like action
                    }) {
                        Image(systemName: "heart.fill")
                            .foregroundColor(.red)
                    }
                    Text("Likes: \(home.likes)")
                        .foregroundColor(.green)

                    Button(action: {
                        // Implement comment action
                    }) {
                        Image(systemName: "message")
                            .foregroundColor(.green)
                    }
                    Text("Comments: \(home.comments.count)")
                        .foregroundColor(.green)

                    Spacer()

                    Button(action: {
                        // Implement share action
                    }) {
                        Image(systemName: "square.and.arrow.up")
                            .foregroundColor(.green)
                    }
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 2)
            .padding(.vertical, 5)
            .border(Color.green, width: 2)
        }
    }

    struct TrandView_Previews: PreviewProvider {
        static var previews: some View {
            TrandView()
        }
    }
