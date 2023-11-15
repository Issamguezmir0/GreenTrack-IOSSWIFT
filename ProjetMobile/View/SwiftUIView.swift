//
//  SwiftUIView.swift
//  MobileApp
//
//  Created by ichrakbenmahmoud on 7/11/2023.
//

import SwiftUI
import MapKit

struct ContentsView: View {
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 36.8757855, longitude: 10.1778645), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.1))
    
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
                    ZStack {
                        
                        Map(coordinateRegion: $region, showsUserLocation: true)
                            .ignoresSafeArea()

                        VStack {
                            HStack {
                                TextField("Search Eco_points.....", text: $searchText)
                                    .font(.subheadline)
                                    .padding(15)
                                    .background(Color.white)
                                    .cornerRadius(10)
                                    .padding()
                                    .shadow(radius: 10)
                                    Button(action: {
                                    // Logique de recherche
                                    performSearch()
                                }) {
                                    Image(systemName: "magnifyingglass")
                                }
                                .padding(.trailing, 27)
                            }
                            Spacer()
                        }
                    }
                }
                .navigationBarHidden(false)
            }

            func performSearch() {
                
            }
        }

     


struct SwiftUIView: View {
    @State private var isNavigationActive = false // Utilisez cet état pour activer la navigation

    var body: some View {
        NavigationView {
            VStack {
                // Autres contenus

                NavigationLink(
                                    destination: ContentsView(),
                                    isActive: $isNavigationActive,
                                    label: {
                                        EmptyView() // This is used to hide the navigation link
                                    }
                                )

                Image("3736569")
                    .resizable()
                    .frame(width: 350, height: 280)

                Text("Think Before Your Trash")
                                .font(.title)
                                .padding(.bottom, 20)
                                .bold()
                            
                            Text("“ The greatest threat to our planet is the belief that someone else will save it, In fact, look for eco-points to add them to collect as many eco-points as possible ”")
                                .multilineTextAlignment(.center)
                                .font(.headline)
                                .padding(.bottom, 80)
                                .padding(.horizontal, 30)
                
                
                
                
                // Autres contenus

                Button(action: {
                    print("Bouton maps appuyé")
                    isNavigationActive = true // Active la navigation lorsque le bouton est appuyé
                }) {
                    Label(
                        title: {
                            Text("Go Maps")
                                .fontWeight(.semibold)
                                .font(.title)
                        },
                        icon: {
                            Image(systemName: "location")
                                .font(.title)
                        }
                    )
                }
                .padding()
                .background(LinearGradient(gradient: Gradient(colors: [Color.yellow, Color.green]), startPoint: .leading, endPoint: .trailing))
                .foregroundColor(.white)
                .cornerRadius(30.0)
            }
        }
    }
}
struct SwiftUIView_Previews: PreviewProvider{
    static var previews: some View{
       SwiftUIView()
    }
}
