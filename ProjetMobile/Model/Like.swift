//
//  Like.swift
//  ProjetMobile
//
//  Created by Bechir Kefi on 14/11/2023.
//

import SwiftUI

struct Like: Identifiable {
    var id: UUID = .init()
    var tappedRect: CGPoint = .zero
    var isAnimated: Bool = false
}
