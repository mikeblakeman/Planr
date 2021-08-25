//
//  ContentView.swift
//  Planr
//
//  Created by Blakeman, Mike on 8/25/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .padding()
    }

    var engineer = Engineer(name: "Derek", platform: [Platform.ios, Platform.android], unavailableDates: [Date().addingTimeInterval(86400)])

    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
