//
//  PlanrApp.swift
//  Planr
//
//  Created by Blakeman, Mike on 8/25/21.
//

import SwiftUI

@main
struct PlanrApp: App {
    @AppStorage(Constants.averageVelocityKey) var velocity = 8
    @AppStorage(Constants.sprintLengthKey) var sprintLength = 2
    @AppStorage(Constants.estimatePaddingKey) var estimatePadding = "0"

    var body: some Scene {
        WindowGroup {
            RootView()
        }
        Settings {
            PlanrSettingsView()
        }
    }
}
