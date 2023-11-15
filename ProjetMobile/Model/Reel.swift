//
//  Reel.swift
//  ProjetMobile
//
//  Created by Bechir Kefi on 14/11/2023.
//
import SwiftUI

struct Reel: Identifiable {
    var id: UUID = .init()
    var videoID: String
    var authorName: String
    var isLiked: Bool = false
}

var reelsData: [Reel] = [
    .init(videoID: "video1", authorName: "Mohamed Bechir Kefi"),
    .init(videoID: "video2", authorName: "Atef Benharb"),
    .init(videoID: "video3", authorName: "Manel Zaabi"),
    .init(videoID: "video4", authorName: "Manar debiche"),
    .init(videoID: "video5", authorName: "Issam guezmir"),
    .init(videoID: "video6", authorName: "Ichrak ben mahmoud")
]
