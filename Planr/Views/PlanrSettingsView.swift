//
//  PlanrSettingsView.swift
//  Planr
//
//  Created by Blakeman, Mike on 11/8/21.
//

import SwiftUI

struct PlanrSettingsView: View {

    private let appSettingsGroupView = AppSettingsGroupView()

    var body: some View {
        VStack(alignment: .center, spacing: 40, content: {
            LinearGradient(gradient: Gradient(colors: [Constants.firstGradientColor,
                                                       Constants.lastGradientColor]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
                .mask(Text("Planr Settings").font(.system(size: 37, weight: .semibold)))
                .frame(maxHeight: 100)
            VStack(alignment: .leading, spacing: 5, content: {
                self.appSettingsGroupView
            }).padding(.horizontal, 25)
        })
        .frame(minWidth: 1000,
               idealWidth: 1200,
               maxWidth: .infinity,
               minHeight: 800,
               idealHeight: 1000,
               maxHeight: .infinity,
               alignment: .top)
        .background(Color(white: 1)).edgesIgnoringSafeArea(.all)
    }
}

struct PlanrSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        PlanrSettingsView().frame(width: 1200, height: 1000, alignment: .center)
    }
}
