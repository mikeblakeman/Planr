//
//  Util.swift
//  Planr
//
//  Created by Blakeman, Mike on 11/4/21.
//

import SwiftUI
import RealmSwift

// Util method to get a random color
func randomColor() -> Color {
    return Color(Color.RGBColorSpace.sRGB,
                 red: .random(in: 0...1),
                 green: .random(in: 0...1),
                 blue: .random(in: 0...1))
}

// Util method to get a demo project
func getDemoProject() -> Project {
    let demoProject = Project(name: "Demo project", startDate: Date())

    // swiftlint:disable line_length
    demoProject.addEngineers(getDemoEngineerList())
    demoProject.addFeatures(getDemoUnplannedFeatureList())

    return demoProject
}

// Util method to get a demo roadmap
func getDemoRoadmap() -> Roadmap {
    let planningCoordinator = PlanningCoordinator(project: getDemoProject())

    let roadmap = planningCoordinator.plan()
    roadmap.printRoadmap()
    return roadmap
}

// Util method to get a list of Engineers
func getDemoEngineerList() -> [Engineer] {
    let collin = Engineer(firstName: "Collin", lastName: "Engineer", platform: [.android], unavailableDates: [Date(), Date().addingTimeInterval(170000)])
    let ellen = Engineer(firstName: "Ellen", lastName: "Engineer", platform: [.ios, .android], unavailableDates: [])
    let ashley = Engineer(firstName: "Ashley", lastName: "Engineer", platform: [.ios, .android], unavailableDates: [])
    let logan = Engineer(firstName: "Logan", lastName: "Engineer", platform: [.ios, .android], unavailableDates: [])
    let pat = Engineer(firstName: "Pat", lastName: "Engineer", platform: [.ios], unavailableDates: [])

    return [collin, ellen, ashley, logan, pat]
}

// Util method to get a list of unplanned feature
func getDemoUnplannedFeatureList() -> [UnplannedFeature] {
    let feature1 = UnplannedFeature(name: "OAuth 2.0", "This is a summary", platform: [.ios, .android], effortEstimate: 16, priority: 300)
    let feature2 = UnplannedFeature(name: "Device Setup", nil, platform: [.ios, .android], effortEstimate: 3, priority: 900)
    let feature3 = UnplannedFeature(name: "Family Roles", nil, platform: [.ios, .android], effortEstimate: 16, priority: 1000)
    let feature4 = UnplannedFeature(name: "Device Communication", nil, platform: [.ios, .android], effortEstimate: 12, priority: 250)
    let feature5 = UnplannedFeature(name: "Text / Voice Messaging", nil, platform: [.ios, .android], effortEstimate: 3, priority: 250)
    let feature6 = UnplannedFeature(name: "GDPR", nil, platform: [.ios, .android], effortEstimate: 6, priority: 200)
    let feature7 = UnplannedFeature(name: "Graphics Updates", nil, platform: [.ios, .android], effortEstimate: 3, priority: 200)
    let feature8 = UnplannedFeature(name: "Emojis", nil, platform: [.ios, .android], effortEstimate: 14, priority: 200)
    let feature9 = UnplannedFeature(name: "WiFi Improvments", nil, platform: [.ios, .android], effortEstimate: 7, priority: 1000)

    return [feature1, feature2, feature3, feature4, feature5, feature6, feature7, feature8, feature9]
}

// Util method to get a filled out Sprint
func getDemoSprint() -> Sprint {

    let now = Date()
    let nextWeek = now.addingTimeInterval(7.0 * 24.0 * 3600.0)
    let dateInterval = DateInterval(start: now, end: nextWeek)

    let sprint = Sprint(workBlocks: getDemoWorkBlocks(), pointsRemaining: 8, dateRange: dateInterval)
    return sprint
}

// Util method to get a filled out list of work blocks
func getDemoWorkBlocks() -> [WorkBlock] {
    let workBlock1 = WorkBlock(name: "Family Accounts",
                               summary: "Cool family feature.",
                               platform: Platform.ios,
                               pointValue: 8,
                               color: randomColor())

    let workBlock2 = WorkBlock(name: "Device Setup",
                               summary: "Device setup feature.",
                               platform: Platform.android,
                               pointValue: 4,
                               color: randomColor())
    workBlock2.isFinalSprint = true
    return [workBlock1, workBlock2]
}
