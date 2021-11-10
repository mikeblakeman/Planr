//
//  ContentView.swift
//  Planr
//
//  Created by Blakeman, Mike on 8/25/21.
//

import SwiftUI
import NavigationStack

struct WelcomeView: View {

    @State private var showContinue = false
    @EnvironmentObject private var navigationStack: NavigationStack

    var body: some View {
        VStack {
            LinearGradient(gradient: Gradient(colors: [Constants.firstGradientColor,
                                                       Constants.lastGradientColor]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
                .mask(
                    Text("Planr").font(.system(size: 224, weight: .semibold))
                )
            Button(action: {
                DispatchQueue.main.async {
                    self.navigationStack.push(NewProjectView())
                }
            }, label: {
                HStack {
                    Image(systemName: "pencil.circle.fill")
                        .font(.system(size: 22.0))
                    Text("Start New Project")
                        .font(.system(size: 18.0))
                }
            }).buttonStyle(GradientButtonStyle())
            .padding(100)
        }.background(Color.white)
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView().frame(width: 1200, height: 1000, alignment: .center)
    }
}
