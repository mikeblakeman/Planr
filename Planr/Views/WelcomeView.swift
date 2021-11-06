//
//  ContentView.swift
//  Planr
//
//  Created by Blakeman, Mike on 8/25/21.
//

import SwiftUI

struct WelcomeView: View {

    @State private var showContinue = false

    var body: some View {
        VStack(alignment: .center, spacing: 40, content: {
            Text("Planr")
                .gradientForeground(colors: [Constants.firstGradientColor,
                                             Constants.lastGradientColor])
                .padding(.horizontal, 150)
                .padding(.vertical, 150)
                .font(.system(size: 224, weight: .semibold))
            Button(action: {
                print("Button action")
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
