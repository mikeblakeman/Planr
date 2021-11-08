//
//  Util.swift
//  Planr
//
//  Created by Blakeman, Mike on 11/4/21.
//

import SwiftUI

func randomColor() -> Color {
    return Color(Color.RGBColorSpace.sRGB,
                 red: .random(in: 0...1),
                 green: .random(in: 0...1),
                 blue: .random(in: 0...1))
}

func getDemoRoadmap() -> Roadmap {
    var project = Project(name: "Test Project 1")

    // swiftlint:disable line_length
    let collin = Engineer(firstName: "Collin", lastName: "Engineer", platform: [.android], unavailableDates: [])
    let ellen = Engineer(firstName: "Ellen", lastName: "Engineer", platform: [.ios, .android], unavailableDates: [])
    let ashley = Engineer(firstName: "Ashley", lastName: "Engineer", platform: [.ios, .android], unavailableDates: [])
    let logan = Engineer(firstName: "Logan", lastName: "Engineer", platform: [.ios, .android], unavailableDates: [])
    let pat = Engineer(firstName: "Pat", lastName: "Engineer", platform: [.ios], unavailableDates: [])

    project.addEngineers([collin, ellen, ashley, logan, pat])

    let feature1 = UnplannedFeature(name: "OAuth 2.0", nil, platform: [.ios, .android], effortEstimate: 16, priority: 300)
    let feature2 = UnplannedFeature(name: "Device Setup", nil, platform: [.ios, .android], effortEstimate: 3, priority: 900)
    let feature3 = UnplannedFeature(name: "Family Roles", nil, platform: [.ios, .android], effortEstimate: 16, priority: 1000)
    let feature4 = UnplannedFeature(name: "Device Communication", nil, platform: [.ios, .android], effortEstimate: 12, priority: 250)
    let feature5 = UnplannedFeature(name: "Text / Voice Messaging", nil, platform: [.ios, .android], effortEstimate: 3, priority: 250)
    let feature6 = UnplannedFeature(name: "GDPR", nil, platform: [.ios, .android], effortEstimate: 6, priority: 200)
    let feature7 = UnplannedFeature(name: "Graphics Updates", nil, platform: [.ios, .android], effortEstimate: 3, priority: 200)
    let feature8 = UnplannedFeature(name: "Emojis", nil, platform: [.ios, .android], effortEstimate: 14, priority: 200)
    let feature9 = UnplannedFeature(name: "WiFi Improvments", nil, platform: [.ios, .android], effortEstimate: 7, priority: 1000)

    project.addFeatures([feature1, feature2, feature3, feature4, feature5, feature6, feature7, feature8, feature9])
    // swiftlint:enable line_length

    let formatter = DateFormatter()
    formatter.dateFormat = "MM/dd/yyyy"
    let date = formatter.date(from: "8/30/2021")!

    let planningCoordinator = PlanningCoordinator(project: project,
                                                  sprintStartDate: date,
                                                  averageVelocity: 8,
                                                  sprintLength: 2,
                                                  estimatePadding: 0.0)

    let roadmap = planningCoordinator.plan()
    roadmap.printRoadmap()
    return roadmap
}
