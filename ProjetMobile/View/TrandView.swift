//
//  TrandView.swift
//  ProjetMobile
//
//  Created by Apple Esprit on 14/11/2023.
//

import SwiftUI
struct Article: Identifiable {
    var id = UUID()
    var title: String
    var content: String
    var likes: Int
    var comments: [String]
    var isLiked: Bool = false
}

struct TrandView: View {
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
}

struct HomePlayerView: View {
    var home: HomePlayers
   
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(home.description ?? "")
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
//                Text("Likes: \(home.likes)")
//                    .foregroundColor(.green)

                Button(action: {
                    // Implement comment action
                }) {
                    Image(systemName: "message")
                        .foregroundColor(.green)
                }
//                Text("Comments: \(home.comments.count)")
//                    .foregroundColor(.green)

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

//struct Article: Identifiable {
//    var id = UUID()
//    var title: String
//    var content: String
//    var likes: Int
//    var comments: [String]
//    var isLiked: Bool = false
//}
//struct TrandView: View {
//    @State private var showStory = false
//    @State private var offsetY: CGFloat = 0
//    @State private var scale: CGFloat = 1
//    @State private var showBarrier = false
//    @State private var opacity: Double = 1
//    @State private var selectedIndex = 0
//
////    @State private var articles: [Article] = [
////            Article(title: "Use public transportation", content: "Leave your car behind and take a \ngreener route, walking, biking or \npublic transport. Reduce emissions, \nsave money, and stay fit on the go.", likes: 10, comments: ["Commentaire 1", "Commentaire 2"]),
////            Article(title: "Reduce, reuse, and recycle", content: "a simple mantra that encourages us \nto be mindful of our consumption \nhabits and minimize waste by finding \nnew uses for existing items", likes: 15, comments: ["Commentaire 1"]),
////            Article(title: "Économies financières", content: "Les coûts liés à la possession et à l'entretien d'un véhicule personnel peuvent être considérables. En utilisant les transports en commun, vous économiserez de l'argent sur l'essence, l'assurance automobile, le stationnement et les réparations. De plus, de nombreuses villes proposent des abonnements mensuels ou annuels abordables pour les utilisateurs fréquents de transports en commun.", likes: 10, comments: ["Commentaire 1", "Commentaire 2"]),
////            Article(title: "Amélioration de la santé", content: "Marcher jusqu'à l'arrêt de bus ou de métro, ou même faire du vélo pour rejoindre votre destination finale, vous permet de rester actif et en forme. Cela contribue à améliorer votre santé cardiovasculaire, à renforcer vos muscles et à augmenter votre niveau d'énergie. Les avantages pour votre bien-être général sont nombreux.", likes: 15, comments: ["Commentaire 1"]),
////            Article(title: "Réduction de la congestion routière ", content: "Plus de personnes utilisant les transports en commun signifie moins de voitures sur la route. Cela entraîne une réduction de la congestion routière, ce qui équivaut à moins de temps perdu dans les embouteillages et à une meilleure fluidité du trafic pour tous.", likes: 15, comments: ["Commentaire 1"]),
////            Article(title: "Accès à du temps libre ", content: "Lorsque vous voyagez en transports en commun, vous avez l'opportunité de consacrer du temps à des activités personnelles. Vous pouvez lire un livre, écouter de la musique, répondre à des e-mails ou même méditer. C'est un moment idéal pour la détente et la productivité.", likes: 15, comments: ["Commentaire 1"]),
////            // Add more articles as needed
////        ]
//
//    @Namespace private var storyNamespace
//    @Namespace private var thumbNamespace
//
//    private let storyOpeningDuration = 0.2
//
//    private let deviceHeight = UIScreen.self.main.bounds.height
//    var body: some View {
//        ZStack{
//            NavigationView{
//                ScrollView(showsIndicators: false){
//                    VStack(spacing:16){
//                        StoriesThumbView(
//                            showStory: $showStory ,
//                            showBarrier: $showBarrier,
//                            selectedIndex: $selectedIndex,
//                            storyNamespace: storyNamespace,
//                            thumbNamespace: thumbNamespace,
//                            duration: storyOpeningDuration
//                        )
//                        ForEach(articles) { article in
//                                                    ArticleView(article: article)
//                                                }
//                                            }
//                                            .padding()
//                                        }
//
//
//
//                        //ZStack {
//                            // Background or Frame
//
//                           // VStack(spacing: 15) {
//
//                                // Your posts or content
//                                //PostsView()
//
//                            //}
//                            //.padding()
//                     //   }
//
//
//                  //  }
//
//                .navigationTitle("Articles")
//                .navigationBarTitleDisplayMode(.inline)
//            }
//
//            if showBarrier{
//                Rectangle()
//                    .foregroundColor(.black.opacity(opacity))
//                    .ignoresSafeArea()
//            }
//            ForEach(1..<11){ index in
//                if selectedIndex == index {
//                    StoryView(
//                        showStory: $showStory,
//                        storyNamespace: storyNamespace,
//                        thumbNamespace: thumbNamespace,
//                        index: index
//
//                    )
//                    .offset(y: offsetY)
//                    .scaleEffect(scale)
//                    .gesture(
//                        DragGesture()
//                            .onChanged(onDrag)
//                            .onEnded(onDragEnd)
//                    )
//                }}
//        }}
//    private func onDrag(_ value: DragGesture.Value){
//        let dy = value.translation.height
//        if dy >= 0.0 {
//            offsetY = dy/2
//            scale = 1 - ((dy/deviceHeight)/10)
//            opacity = 1 - dy/deviceHeight
//        }
//
//    }
//    private func onDragEnd(_ value: DragGesture.Value){
//        let dy = value.translation.height
//        if dy >= 0.0 {
//            if dy <= deviceHeight/2{
//                withAnimation{
//                    offsetY = 0.0
//                    scale = 1.0
//                    opacity = 1.0
//                }
//            } else{
//                showBarrier.toggle()
//                withAnimation(.easeIn(duration: 0.4)){
//                    showStory.toggle()
//                }
//                offsetY = 0.0
//                scale = 1.0
//                opacity = 1.0
//
//            }
//        }
//    }
//    //ScrollView(.vertical,showsIndicators: false, content: {
//      //  VStack(spacing: 12){
//        //    ForEach(articles){
//          //      Article1 in
//            //}
//        //}
//    //})
//
//
//}
//struct ArticleView: View {
//    var article: Article
//
//    var body: some View {
//        VStack(alignment: .leading, spacing: 20) {
//            Text(article.title)
//                .font(.headline)
//            Text(article.content)
//                .font(.subheadline)
//                .foregroundColor(.gray)
//
//            HStack {
//                Button(action: {
//                    // Action du bouton "J'aime"
//                    // Implement the like action
//                }) {
//                    Image(systemName: article.isLiked ? "heart.fill" : "heart")
//                        .foregroundColor(article.isLiked ? .red : .green)
//                }
//                Text("\(article.likes)")
//                    .foregroundColor(.green)
//
//                Button(action: {
//                    // Action du bouton "Commentaire"
//                    // Implement the comment action
//                }) {
//                    Image(systemName: "message")
//                        .foregroundColor(.green)
//                }
//                Text("\(article.comments.count)")
//                    .foregroundColor(.green)
//
//                Spacer()
//
//                Button(action: {
//                    // Action du bouton "Partage"
//                    // Implement the share action
//                }) {
//                    Image(systemName: "square.and.arrow.up")
//                        .foregroundColor(.green)
//                }
//            }
//        }
//        .padding()
//        .background(Color.white)
//        .cornerRadius(10)
//        .shadow(radius: 2)
//        .padding(.vertical, 5)
//        .border(Color.green, width: 2)
//    }
//}

struct TrandView_Previews: PreviewProvider {
    static var previews: some View {
        TrandView()
    }
}
