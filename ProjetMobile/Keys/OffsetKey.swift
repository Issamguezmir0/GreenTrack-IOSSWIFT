//
//  OffsetKey.swift
//  InstaFeed
//
//  Created by Bechir Kefi on 14/11/2023.
//

import SwiftUI

struct OffsetKey: PreferenceKey {

    static var defaultValue: CGRect = .zero
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}

