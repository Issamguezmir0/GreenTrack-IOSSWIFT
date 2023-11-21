import SwiftUI

struct ChallengeView: View {
    @ObservedObject var eventsViewModel = EventViewModel()

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Add a wide image and a button at the top
                    WideImageView()

                    LazyVGrid(columns: [GridItem(.flexible(), spacing: 30), GridItem(.flexible(), spacing: 30)], spacing: 40) {
                        ForEach(eventsViewModel.events, id: \.id) { event in
                            ChallengeCard(event: event)
                        }
                    }
                }
                .padding()
            }
            .onAppear {
                // Call the getEvents function when the view appears
                eventsViewModel.getEvents()
            }
            .navigationBarHidden(true) // Hide the navigation bar
        }
    }
}
struct WideImageView: View {
    var body: some View {
        VStack {
            Image("Rectangle 33") // Replace with your wide image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 200) // Adjust the height as needed
                .clipped()

            Text("Join us!")
                .font(Font.custom("Poppins", size: 20).weight(.semibold))
                .foregroundColor(Color.black)
                .padding()
                .background(Color.white.opacity(0.3)) // Customize the background color if needed
                .cornerRadius(8)
                .padding(.top, -30) // Adjust the top padding as needed
                .padding(.bottom, 20)
                .shadow(radius: 3)
        }
    }
}


struct ChallengeCard: View {
    let event: Event

    var body: some View {
        NavigationLink(destination: ViewDetailsD(event: event)) {
            VStack(spacing: 2) {
                Image("Rectangle 56") // Use your image here
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 80, height: 80) // Square card
                    .cornerRadius(12)

                Spacer()

                Text(event.title)
                    .font(Font.custom("Poppins", size: 20).weight(.medium))
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                    .lineLimit(2)
                    .padding(.horizontal) // Center the title

                Spacer()

                Text("Join")
                    .font(Font.custom("Poppins", size: 10).weight(.medium))
                    .foregroundColor(.white)
                    .padding(8)
                    .background(Color(red: 0.44, green: 0.88, blue: 0))
                    .cornerRadius(6)
            }
            .background(Color(red: 0.95, green: 0.95, blue: 0.95))
            .cornerRadius(16)
            .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.1), radius: 5)
        }
    }
}

struct ChallengeView_Previews: PreviewProvider {
    static var previews: some View {
        ChallengeView()
    }
}
