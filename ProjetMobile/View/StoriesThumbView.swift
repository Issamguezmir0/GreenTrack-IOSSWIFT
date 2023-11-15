import SwiftUI


struct StoriesThumbView: View {
    @Binding var showStory: Bool
    @Binding var showBarrier: Bool
    @Binding var selectedIndex: Int
    let storyNamespace: Namespace.ID
    let thumbNamespace: Namespace.ID
    let duration: Double
    @State private var tappedIndex: Int?
    @State private var circleColors: [Color] = Array(repeating: .green, count: 10)

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(1..<11) { index in
                    ZStack {
                        Circle()
                            .stroke(lineWidth: 2.0)
                            .frame(width: 108, height: 108)
                            .foregroundColor(circleColors[index - 1]) // Adjusted to use the array

                        if selectedIndex == index && !showStory {
                            ZStack {
                                // Background
                                Image("story\(index)")
                                    .resizable()
                                    .scaledToFit()
                                    .clipShape(RoundedRectangle(cornerRadius: 4))
                            }
                            .matchedGeometryEffect(id: "story\(index)", in: storyNamespace)
                            .transition(.scale(scale: 1))
                            .frame(width: 40, height: 80)
                        }

                        if !showStory || selectedIndex != index {
                            Image("thumb\(index)")
                                .resizable()
                                .scaledToFit()
                                .clipShape(Circle())
                                .matchedGeometryEffect(id: "thumb\(index)", in: thumbNamespace)
                                .transition(.scale(scale: 1))
                                .frame(width: 100, height: 100)
                                .onTapGesture {
                                    tappedIndex = index
                                    selectedIndex = index
                                    withAnimation(.easeOut(duration: duration)) {
                                        showStory.toggle()
                                        // Update only the tapped story's color
                                        circleColors[index - 1] = (circleColors[index - 1] == .green) ? .gray : .green
                                    }
                                    withAnimation(.linear.delay(duration)) {
                                        showBarrier.toggle()
                                    }
                                }
                        }
                    }
                }
            }
            .padding(16)
        }
    }
}
