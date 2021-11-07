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
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
