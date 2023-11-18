//
//  ViewDetailsD.swift
//  ProjetMobile
//
//  Created by manel zaabi on 7/11/2023.
//


import SwiftUI

enum Tab {
    case details , comments
}






struct ViewDetailsD: View {
    
    @State private var showCommentView = false
    
    @State private var isDetailsExpanded = false
    
    
    var event: Event
    
    var body: some View {
       
            ScrollView{
                VStack(alignment: .leading, spacing: 20) {
                    Rectangle()
                        .frame(width: 360, height: 210)
                        .foregroundColor(.clear)
                        .background(Image("Rectangle 33"))
                        .cornerRadius(30)
                        .offset(x: 0, y: 0)
                    Text(event.title )
                        .font(.title)
                        .fontWeight(.bold)
                    Text(event.description )
                        .font(.body)
                        .multilineTextAlignment(.leading)
                    HStack {
                        Image(systemName: "person")
                            .foregroundColor(.green)
                        
                        if !event.organisateurs.isEmpty {
                            ForEach(event.organisateurs, id: \.self) { organisateurs in
                                Text(organisateurs)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                        } else {
                            Text("No organizer specified")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }

                    HStack {
                        Image(systemName: "calendar")
                            .foregroundColor(.green)
                        Text("Planned : \(event.date?.formatted() ?? "")")
                    }

                    HStack {
                        Image(systemName: "location")
                            .foregroundColor(.green)
                        Text("Location: \(event.location )")
                        .font(.subheadline)
                           .foregroundColor(.gray)
                    }

                    HStack {
                        Image(systemName: "person.3")
                            .foregroundColor(.green)
                        
                        if !event.participants.isEmpty {
                            ForEach(event.participants, id: \.self) { participants in
                                Text(participants)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                        } else {
                            Text("No participants specified")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }


                    
                    if let isFree = event.isFree {
                        if isFree {
                            Text("Free Event")
                                .font(.subheadline)
                                .foregroundColor(.green)
                        } else {
                            Text("Paid Event")
                                .font(.subheadline)
                                .foregroundColor(.red)
                        }
                    } else {
                        // Handle the case when isFree is nil
                        // You might want to provide a default behavior or display an error message
                    }

                    
                    
                    
                    HStack {
                        
                        Button(action: {
                            self.isDetailsExpanded.toggle()
                        }){
                            Text("Join")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.green)
                                .foregroundColor(.white)
                                .cornerRadius(5)
                        }
                        .padding(.horizontal)
                        
                        Button(action: {
                            self.showCommentView = true
                        }){
                            Text("Comments")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.white)
                                .foregroundColor(.gray)
                                .cornerRadius(5)
                                .shadow(radius: 1 )
                                
                        }
                        .buttonStyle(PlainButtonStyle())
                        .sheet(isPresented: $showCommentView) {
                            CommentView()  }
                        
                        
                        
                        
                        
                        Spacer()
                        
                            .padding()
                            .navigationBarTitle("Event Details", displayMode: .inline)
                    }
                    VStack{
                        DisclosureGroup("Details", isExpanded: $isDetailsExpanded) {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("A propos")
                                    .font(.headline)
                                    
                                Text(event.details)
                                    .font(.body)
                            }
                            
                        }}
                   
                }
                .padding(.leading,30)// Details Section
                
            }}}
        
        struct DetailsView: View {
            var event: Event
            
            var body: some View {
                VStack {
                    // Add details specific to the DetailsView
                    Text("Details View")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding()
                    Text("Event Description :\(event.description )")
                        .font(.body)
                        .padding()
                    Image(systemName: "calendar")
                        .foregroundColor(.green)
                    Text("Date: \(event.date?.formatted() ?? "" )")
                    Text(event.details)
                        .font(.body)
                    
                    
                }
            }
        }
        
        
        struct CommentView: View {
            
            var comments: [String] = ["Great event!", "Looking forward to it!", "Awesome opportunity!","Great event!", "Looking forward to it!", "Awesome opportunity!"]
            
            var body: some View {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Comments")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.green)

                    List(comments, id: \.self) { comment in
                        CommentRow(comment: comment)
                    }
                    
                    Spacer()
                }
                .padding()
                .navigationBarTitle("Commentaires", displayMode: .inline)
            }
        }
        struct CommentRow: View {
            var comment: String
            
            var body: some View {
                HStack {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
                        .aspectRatio(contentMode: .fill)
                    
                    Text(comment)
                        .padding(.leading, 8)
                    
                    Spacer()
                }
            }
        }

        
//        struct ViewDetailsD_Previews: PreviewProvider {
//            static var previews: some View {
//                let sampleFreeEvent = Event(title: "Green Wear", date: "November 30, 2023", location: "123 Main St, Cityville", description: "Join us Join Join us for a networking event to connect with professionals in the industry. ", isFree: true, participants: ["John Doe", "Jane Smith"], organisateur: ["John Doe"],details: "Join us Join Join us for a networking event to connect!!!!! with professionals")
//                let samplePaidEvent = Event(title: "Conference", date: "December 15, 2023", location: "456 Park Ave, Townsville", description: "A conference on the latest industry trends.", isFree: false,participants: ["John Doe", "Jane Smith"], organisateur: ["John Doe"], details: "Join us Join Join us for a networking event to connect with professionals in")
//
//                return Group {
//                    ViewDetailsD(event: sampleFreeEvent)
//                    ViewDetailsD(event: samplePaidEvent)
//                }
//
//
//            }
//        }
//
 
