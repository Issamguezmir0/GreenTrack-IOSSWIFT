//
//  ContentView.swift
//  MobileApp
//
//  Created by ichrakbenmahmoud on 14/11/2023.
//

import SwiftUI

import MapKit



struct ContentView: View {

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



     

struct ContentView_Previews: PreviewProvider{

    static var previews: some View{

       SwiftUIView()

    }

}
