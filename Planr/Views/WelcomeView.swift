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
//    @ObservedObject var viewModel: WelcomeViewModel
    @EnvironmentObject private var navigationStack: NavigationStack

    var body: some View {
        VStack(alignment: .center, spacing: 40, content: {
            LinearGradient(gradient: Gradient(colors: [Constants.firstGradientColor,
                                                       Constants.lastGradientColor]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
                .mask(
                    Text("Planr")
                        .padding(.horizontal, 150)
                        .padding(.vertical, 150)
                        .font(.system(size: 224, weight: .semibold))
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
        })
        .frame(minWidth: 1000,
               idealWidth: 1200,
               maxWidth: .infinity,
               minHeight: 800,
               idealHeight: 1000,
               maxHeight: .infinity,
               alignment: .center)
        .background(Color(white: 1)).edgesIgnoringSafeArea(.all)
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
