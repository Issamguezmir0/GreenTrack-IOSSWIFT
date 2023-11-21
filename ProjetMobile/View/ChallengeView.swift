//
//  ChallengeView.swift
//  ProjetMobile
//
//  Created by manel zaabi on 7/11/2023.
//

//import SwiftUI
//
//struct ChallengeView: View {
//    @ObservedObject var eventsViewModel = EventViewModel()
//    var body: some View {
//        NavigationView {
//
//            ZStack() {
//                Rectangle()
//                    .frame(width: 350, height: 210)
//                    .foregroundColor(.clear)
//                    .background(Image("Rectangle 33"))
//                    .cornerRadius(16)
//                    .offset(x: 0, y: -256)
//
//                Text("Top Challenges")
//                    .font(Font.custom("Poppins", size: 24).weight(.semibold))
//                    .foregroundColor(Color(red: 0.12, green: 0.12, blue: 0.12))
//                    .offset(x: -67, y: -108)
//                Button(action: {
//                    // Ajoutez votre action de participation à l'événement ici
//                    print("Participation à l'événement")
//                }) {
//                    ZStack() {
//                        Rectangle()
//                            .foregroundColor(.clear)
//                            .frame(width: 130, height: 30)
//
//                            .background(Color(red: 1, green: 1, blue: 1).opacity(10))
//                            .cornerRadius(14)
//                            .offset(x: 0, y: 0)
//
//                        Text("Join us!")
//                            .font(Font.custom("Poppins", size: 20).weight(.semibold))
//                            .foregroundColor(Color(red: 0, green: 4, blue: 0).opacity(15))
//
//                            .offset(x: 0, y: 0)
//                        ZStack() {
//                            // Contenu de la superposition interne (le cas échéant)
//                        }
//                    }
//                }
//                .frame(width: 126, height: 34)
//                .offset(x: -97, y: -186)
//                .opacity(0.50)
//                Button(action: {
//                    // Ajoutez votre logique de participation à l'événement ici
//                    print("Participation à l'événement")
//                }) {
//                    ZStack() {
//                        Rectangle()
//                            .foregroundColor(.clear)
//                            .frame(width: 164, height: 185)
//                            .background(Color(red: 0.95, green: 0.95, blue: 0.95))
//                            .cornerRadius(16)
//                            .offset(x: 0, y: 0)
//                        Rectangle()
//                            .foregroundColor(.clear)
//                            .frame(width: 134, height: 100)
//                            .background(
//                                Image("Rectangle 56"))
//                            .cornerRadius(12)
//                            .offset(x: 0, y: -27.50)
//                        NavigationLink(
//                            destination: ViewDetailsD(event: eventsViewModel.selectedEvent ?? Event())
//                        ) {
//                            Text(eventsViewModel.selectedEventTitle ?? "Default Title")
//                                .font(Font.custom("Poppins", size: 14).weight(.medium))
//                                .foregroundColor(.black)
//                                .offset(x: -0.50, y: 41)
//                        }
//
//
//
//
//
//                        Rectangle()
//                            .foregroundColor(.clear)
//                            .frame(width: 65, height: 21)
//                            .background(Color(red: 0.44, green: 0.88, blue: 0))
//                            .cornerRadius(6)
//                            .offset(x: -0.50, y: 67)
//
//                        Text("Join")
//                            .font(Font.custom("Poppins", size: 10).weight(.medium))
//                            .foregroundColor(.white)
//                            .offset(x: 0, y: 67)
//                    }
//                }
//                .frame(width: 164, height: 185)
//                .offset(x: -92, y: 32.50)
//
//                Button(action: {
//                    // Ajoutez votre logique de participation à l'événement ici
//                    print("Join")
//                }) {
//                    ZStack() {
//                        Rectangle()
//                            .foregroundColor(.clear)
//                            .frame(width: 164, height: 185)
//                            .background(Color(red: 0.95, green: 0.95, blue: 0.95))
//                            .cornerRadius(16)
//                            .offset(x: 0, y: 0)
//                        Rectangle()
//                            .foregroundColor(.clear)
//                            .frame(width: 134, height: 100)
//                            .background(
//                                Image("Rectangle 57"))
//                            .cornerRadius(12)
//                            .offset(x: 0, y: -27.50)
//                        if let selectedEvent = eventsViewModel.selectedEvent {
//                            NavigationLink(destination: ViewDetailsD(event: selectedEvent)) {
//                                Text("Green wear")
//                                    .font(Font.custom("Poppins", size: 14).weight(.medium))
//                                    .foregroundColor(.black)
//                                    .offset(x: -1, y: 41)
//                            }
//                        }
//
//                        Rectangle()
//                            .foregroundColor(.clear)
//                            .frame(width: 65, height: 21)
//                            .background(Color(red: 0.44, green: 0.88, blue: 0))
//                            .cornerRadius(6)
//                            .offset(x: -0.50, y: 67)
//
//                        Text("Join")
//                            .font(Font.custom("Poppins", size: 10).weight(.medium))
//                            .foregroundColor(.white)
//                            .offset(x: 0, y: 67)
//                    }
//                }
//                .frame(width: 164, height: 185)
//                .offset(x: 92, y: 32.50)
//
//                Button(action: {
//                    // Ajoutez votre logique de participation à l'événement ici
//                    print("Join")
//                }) {
//                    ZStack() {
//                        Rectangle()
//                            .foregroundColor(.clear)
//                            .frame(width: 164, height: 185)
//                            .background(Color(red: 0.95, green: 0.95, blue: 0.95))
//                            .cornerRadius(16)
//                            .offset(x: 0, y: 0)
//                        Rectangle()
//                            .foregroundColor(.clear)
//                            .frame(width: 134, height: 100)
//                            .background(
//                                Image("Rectangle 56-2"))
//                            .cornerRadius(12)
//                            .offset(x: 0, y: -27.50)
//                        if let selectedEvent = eventsViewModel.selectedEvent {
//                            NavigationLink(destination: ViewDetailsD(event: selectedEvent)) {
//                                Text("On feet")
//                                    .font(Font.custom("Poppins", size: 14).weight(.medium))
//                                    .foregroundColor(.black)
//                                    .offset(x: -0.50, y: 41)
//                            }
//                        }
//
//
//                        Rectangle()
//                            .foregroundColor(.clear)
//                            .frame(width: 65, height: 21)
//                            .background(Color(red: 0.44, green: 0.88, blue: 0))
//                            .cornerRadius(6)
//                            .offset(x: -0.50, y: 67)
//
//                        Text("Join")
//                            .font(Font.custom("Poppins", size: 10).weight(.medium))
//                            .foregroundColor(.white)
//                            .offset(x: 0, y: 67)
//                    }
//                }
//                .frame(width: 164, height: 185)
//                .offset(x: -93, y: 240.50)
//
//                Button(action: {
//                    // Ajoutez votre logique de participation à l'événement ici
//                    print("Participation à l'événement")
//                }) {
//                    ZStack() {
//                        Rectangle()
//                            .foregroundColor(.clear)
//                            .frame(width: 164, height: 185)
//                            .background(Color(red: 0.95, green: 0.95, blue: 0.95))
//                            .cornerRadius(16)
//                            .offset(x: 0, y: 0)
//                        Rectangle()
//                            .foregroundColor(.clear)
//                            .frame(width: 134, height: 100)
//                            .background(
//                                Image("Rectangle 56-3"))
//                            .cornerRadius(12)
//                            .offset(x: 0, y: -27.50)
//                        if let selectedEvent = eventsViewModel.selectedEvent {
//                            NavigationLink(destination: ViewDetailsD(event: selectedEvent)) {
//                                Text("On feet")
//                                    .font(Font.custom("Poppins", size: 14).weight(.medium))
//                                    .foregroundColor(.black)
//                                    .offset(x: -0.50, y: 41)
//                            }
//                        }
//
//
//                        Rectangle()
//                            .foregroundColor(.clear)
//                            .frame(width: 65, height: 21)
//                            .background(Color(red: 0.44, green: 0.88, blue: 0))
//                            .cornerRadius(6)
//                            .offset(x: -0.50, y: 67)
//
//
//                        Text("Join")
//                            .font(Font.custom("Poppins", size: 10).weight(.medium))
//                            .foregroundColor(.white)
//                            .offset(x: 0, y: 67)
//                    }
//                }
//                .frame(width: 164, height: 185)
//                .offset(x: 91, y: 240.50)
//
//                ZStack() {
//                    ZStack() {
//
//                    }
//                    .frame(width: 30, height: 30)
//                    .offset(x: 139, y: -11)
//                    ZStack() {
//
//                    }
//                    .frame(width: 30, height: 30)
//                    .offset(x: 46, y: -11)
//                    ZStack() {
//
//                    }
//                    .frame(width: 30, height: 30)
//                    .offset(x: -47, y: -11)
//                    ZStack() {
//
//                    }
//                    .frame(width: 30, height: 30)
//                    .offset(x: -140, y: -11)
//                    Rectangle()
//                        .foregroundColor(.clear)
//                        .frame(width: 169.01, height: 0)
//                        .overlay(Rectangle()
//                            .stroke(.black, lineWidth: 2.10))
//                        .offset(x: -0.49, y: 40)
//                    Ellipse()
//                        .foregroundColor(.clear)
//                        .frame(width: 6, height: 6)
//                        .background(Color(red: 0.44, green: 0.88, blue: 0))
//                        .offset(x: 46, y: 7)
//                }
//                .frame(width: 390, height: 100)
//                .background(Color(red: 0.95, green: 0.95, blue: 0.95))
//                .cornerRadius(20)
//                .offset(x: 0, y: 372)
//                .shadow(
//                    color: Color(red: 0, green: 0, blue: 0, opacity: 0.05), radius: 25
//                )
//
//            }
//            .frame(width: 390, height: 844)
//            .background(.white)
//            .cornerRadius(20)
//            .onAppear {
//                           // Call the getEvents function when the view appears
//                           eventsViewModel.getEvents()
//                       }
//
//        }
//        .onAppear {
//            // Call the getEvents function when the view appears
//            eventsViewModel.getEvents()
//        }
//
//
//    }
//}
//
//
//struct ChallengeView_Previews: PreviewProvider {
//    static var previews: some View {
//        ChallengeView()
//    }
//}

import SwiftUI

struct ChallengeView: View {
    @ObservedObject var eventsViewModel = EventViewModel()
    @State private var randomEventImage: String?
    
    var body: some View {
       
        NavigationView {
            ScrollView {
                VStack {
                    Image("Rectangle 33") // Replace with your wide image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 200) // Adjust the height as needed
                        .clipped()
                    //                    if let randomImage = randomEventImage {
                    //                                     Image(randomImage) // Replace with your wide image
                    //                                         .resizable()
                    //                                         .aspectRatio(contentMode: .fill)
                    //                                         .frame(height: 200) // Adjust the height as needed
                    //                                         .clipped()
                    //                                         .onAppear {
                    //                                             randomEventImage = eventsViewModel.randomEventImage()
                    //                                         }
                    //                                 } else {
                    //                                     Text("Loading...") // Placeholder while image is loading
                    //                                 }
                   
                        Text("Join us now")
                            .font(Font.custom("Poppins", size: 20).weight(.semibold))
                            .foregroundColor(Color.black)
                            .padding()
                            .background(Color.white.opacity(0.3)) // Customize the background color if needed
                            .cornerRadius(8)
                            .padding(.top, -30) // Adjust the top padding as needed
                            .padding(.bottom, 20)
                            .shadow(radius: 3)
                    }
                VStack(spacing: 20) {
                    // Add a wide image and a button at the top
                    

                    LazyVGrid(columns: [GridItem(.flexible(), spacing: 30), GridItem(.flexible(), spacing: 30)], spacing: 40) {
                        ForEach(eventsViewModel.events, id: \.id) { event in
                            ChallengeCard(event: event)
                        }
                    }
                }
                .padding()
            }
            .onAppear {
              
                eventsViewModel.getEvents()
                //randomEventImage = eventsViewModel.randomEventImage()
            }
            .navigationBarHidden(true)
        }
    }
}



struct ChallengeCard: View {
    let event: Event
    

    var body: some View {
        NavigationLink(destination: ViewDetailsD(event: event)) {
            VStack(spacing: 2) {
                
                if let eventImage = event.image{  AsyncImage(
                
                    url: URL(string: "\(AppConfig.apiUrl)\(eventImage)")) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 80, height: 80)
                        .cornerRadius(12)
                        .offset(x: 0, y: -27.50)
                        

                } placeholder: {
                    // Placeholder image while loading
                    Image("Rectangle 56") // Use your image here
                                     .resizable()
                                     .aspectRatio(contentMode: .fill)
                                     .frame(width: 80, height: 80) // Square card
                                     .cornerRadius(12)
                }
                   
                }
                

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
        Spacer()
    }
}

struct ChallengeView_Previews: PreviewProvider {
  
                static var previews: some View {
        ChallengeView()
    }
}
