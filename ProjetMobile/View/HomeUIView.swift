//
//  HomeUIView.swift
//  ProjetMobile
//
//  Created by Bechir Kefi on 8/11/2023.
//

import SwiftUI

struct HomeUIView: View {
    @ObservedObject var viewModel: HomeVideoViewModel

    var body: some View {
        NavigationView{
            ScrollView{
                ZStack() {
                    //ZStack() {
                      //  NavigationLink(destination: ChatView()) {
                        //    ZStack() {
                          //      Image("ph_chat-teardrop-dots-fill")
                                
                            //}}
                        //.frame(width: 30, height: 30)
                        //.offset(x: 139, y: -11)
                        //NavigationLink(destination: Messagerie()) {
                          //  ZStack() {
                            //    Image("fluent_people-community-20-filled")
                            //}}
                        //.frame(width: 30, height: 30)
                       // .offset(x: 46, y: -11)
                       // NavigationLink(destination: EnergieView()) {
                           // ZStack() {
                            //    Image("material-symbols_track-changes-rounded")
                           // }}
                       // .frame(width: 30, height: 30)
                       // .offset(x: -47, y: -11)
                       // NavigationLink(destination: HomeUIView()) {
                           // ZStack() {
                                //Image("basil_home-solid")
                           // }}
                       // .frame(width: 30, height: 30)
                       // .offset(x: -140, y: -11)
                      //  Rectangle()
                      //      .foregroundColor(.clear)
                     //       .frame(width: 169.01, height: 0)
                    //        .overlay(Rectangle()
                  //              .stroke(.black, lineWidth: 2.10))
                  //          .offset(x: -0.49, y: 40)
                        
                //    }
                //    .frame(width: 390, height: 100)
                //    .background(Color(red: 0.95, green: 0.95, blue: 0.95))
                //    .cornerRadius(20)
                  //  .offset(x: 0, y: 372)
                  //  .shadow(
                  //      color: Color(red: 0, green: 0, blue: 0, opacity: 0.05), radius: 25
                  //  )
                    Spacer()
                    Text("Good Morning")
                        .font(Font.custom("Poppins", size: 28).weight(.bold))
                        .foregroundColor(Color.green)
                        .foregroundColor(Color(red: 0.12, green: 0.12, blue: 0.12))
                        .offset(x: -42, y: -343)
                   
                    
                    
                    Text("Tips for sustainability")
                        .font(Font.custom("Poppins", size: 24).weight(.semibold))
                        .foregroundColor(Color(red: 0.12, green: 0.12, blue: 0.12))
                        .offset(x: -45, y: -36)
                    
                    
                    ZStack() {
                        
                        
                        Rectangle()
                            .frame(width: 350, height: 210)
                            .foregroundColor(.clear)
                            .background(Image("Rectangle 33"))
                            .cornerRadius(16)
                            .offset(x: 0, y: -10)
                        Text("")
                            .font(Font.custom("Poppins", size: 24).weight(.semibold))
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(Color.black)
                            .multilineTextAlignment(.leading)
                        
                            .offset(x: -100, y: -10)
                        
                        NavigationLink(destination: ChallengeView()) {
                            ZStack() {
                                
                                Rectangle()
                                    .foregroundColor(.clear)
                                    .frame(width: 350, height: 128)
                                    .background(Color(red: 0.95, green: 0.95, blue: 0.95))
                                    .cornerRadius(16)
                                    .offset(x: 0, y: 0)
                                Rectangle()
                                    .foregroundColor(.clear)
                                    .frame(width: 119, height: 100)
                                    .background(
                                        Image("Rectangle 57")
                                    )
                                    .cornerRadius(14)
                                    .offset(x: -101.50, y: -1)
                                Text("Green wear")
                                    .font(Font.custom("Poppins", size: 24).weight(.bold))
                                    .foregroundColor(.black)
                                    .offset(x: 66, y: -11.50)
                                Text("See More  >")
                                    .font(Font.custom("Poppins", size: 9).weight(.medium))
                                    .offset(x: 120, y: 31.50)
                                
                            }
                        }
                        
                        .frame(width: 350, height: 128)
                        .offset(x: 0, y: 68)
                    }
                    .frame(width: 350, height: 222)
                    .offset(x: 0, y: -197)
                    
                    VStack {
                        NavigationLink(destination: TrandView()) {
                            ZStack() {
                                Rectangle()
                                    .foregroundColor(.clear)
                                    .frame(width: 350, height: 128)
                                    .background(Color(red: 0.95, green: 0.95, blue: 0.95))
                                    .cornerRadius(16)
                                    .offset(x: 0, y: 0)
                                Rectangle()
                                    .foregroundColor(.clear)
                                    .frame(width: 119, height: 100)
                                    .background(
                                        Image("Rectangle 40")
                                    )
                                    .cornerRadius(14)
                                    .offset(x: -101.50, y: -1)
                                Text("Use public transportation...")
                                    .font(Font.custom("Poppins", size: 14).weight(.medium))
                                    .foregroundColor(.black)
                                    .offset(x: 66, y: -31.50)
                                Text("Leave your car behind and take a \ngreener route, walking, biking or \npublic transport. Reduce emissions, \nsave money, and stay fit on the go.")
                                    .font(Font.custom("Poppins", size: 10).weight(.medium))
                                    .foregroundColor(Color(red: 0, green: 0, blue: 0).opacity(0.50))
                                    .offset(x: 62, y: 12)
                            }
                        }
                        .frame(width: 350, height: 128)
                    .offset(x: 0, y: 68)
                    }
                    .padding(.top,20)
                    
                    NavigationLink(destination: TrandView()) {
                        ZStack() {
                            Rectangle()
                                .foregroundColor(.clear)
                                .frame(width: 350, height: 128)
                                .background(Color(red: 0.95, green: 0.95, blue: 0.95))
                                .cornerRadius(16)
                                .offset(x: 0, y: 0)
                            Rectangle()
                                .foregroundColor(.clear)
                                .frame(width: 119, height: 100)
                                .background(
                                    Image("Rectangle 41")
                                )
                                .cornerRadius(14)
                                .offset(x: -101.50, y: 0)
                            
                            Text("Reduce, reuse, and recycle")
                                .font(Font.custom("Poppins", size: 14).weight(.medium))
                                .foregroundColor(.black)
                                .offset(x: 65.50, y: -31.50)
                            Text("a simple mantra that encourages us \nto be mindful of our consumption \nhabits and minimize waste by finding \nnew uses for existing items")
                                .font(Font.custom("Poppins", size: 10).weight(.medium))
                                .foregroundColor(Color(red: 0, green: 0, blue: 0).opacity(0.50))
                                .offset(x: 67, y: 12)
                        }}
                    .frame(width: 350, height: 128)
                    .offset(x: 0, y: 218)
                    
                    VStack {
                        
                        Button {
                            // Mettez ici la logique pour déclencher la navigation
                            // Par exemple, vous pouvez utiliser la navigation vers ContentView
                            contenttView(data: $viewModel.data, currentVideoIndex: $viewModel.currentVideoIndex, viewModel: viewModel)
                        } label: {
                            Text("See Videos")
                    }
                    }
                    
                   
                    NavigationLink(destination:  contenttView(data: $viewModel.data, currentVideoIndex: $viewModel.currentVideoIndex, viewModel: viewModel))
                    {
                        ZStack(){
                            Text(" Videos >")
                                .foregroundColor(.white)
                                .offset(x: 120, y: 300)
                                
                         
                            
                        }}
                    ZStack() {
                        ZStack() {
                            Image("mingcute_menu-fill")
                        }
                        .frame(width: 24, height: 24)
                        .offset(x: 0, y: 0)
                    }
                    .frame(width: 24, height: 24)
                    .offset(x: -169, y: -349)
                    NavigationLink(destination: SwiftUIView()) {
                        ZStack() {
                            Image("arcticons_maps")
                        }}
                    .frame(width: 48, height: 48)
                    .offset(x: 151, y: -346)
                    
                    
                }
                .frame(width: 390, height: 844)
                .background(.white)
                .cornerRadius(20);
            }
            
        }}
}
                struct HomeUIView_Previews: PreviewProvider {
                  static var previews: some View {
                      HomeUIView(viewModel: HomeVideoViewModel())
                  }
                }
