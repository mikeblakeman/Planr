//
//  PlanrApp.swift
//  Planr
//
//  Created by Blakeman, Mike on 8/25/21.
//

import SwiftUI
import RealmSwift

@main
struct PlanrApp: SwiftUI.App {
    @StateObject var state = AppState()
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(state)
        }
    }
}
