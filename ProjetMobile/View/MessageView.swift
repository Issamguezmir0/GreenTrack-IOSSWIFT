//
//  MessageView.swift
//  ProjetMobile
//
//  Created by IssamGuezmir on 13/11/2023.
//

import SwiftUI

struct MessageView: View {
    var body: some View {
        Text("Check your phone , SMS  ")
            .font(.largeTitle)
            .fontWeight(.bold)
            .foregroundColor(.green)
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView()
    }
}
