//
//  RootView.swift
//  Planr
//
//  Created by Blakeman, Mike on 11/6/21.
//

import SwiftUI
import NavigationStack

struct RootView: View {
    var body: some View {
        NavigationStackView {
            WelcomeView()
        }.frame(minWidth: 1200,
                maxWidth: .infinity,
                minHeight: 1000,
                maxHeight: .infinity)
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
