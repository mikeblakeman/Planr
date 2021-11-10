//
//  ProjectRoadmapView.swift
//  Planr
//
//  Created by Blakeman, Mike on 11/7/21.
//

import SwiftUI

struct ProjectRoadmapView: View {

    private var projectName: String
    private var roadmap: Roadmap

    init(projectName: String, roadmap: Roadmap) {
        self.projectName = projectName
        self.roadmap = roadmap
    }

    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading, spacing: 5) {
                Text("\(projectName) Roadmap")
                    .font(.system(size: 48, weight: .bold))
                    .padding()
                Divider()
                getPlaceholderMonthView()
                ScrollView(.horizontal) {
                    VStack {
                        PlannedSprintView(platform: Platform(value: PlatformType.ios),
                                          sprints: roadmap.sprints)
                        Spacer().frame(height: 50)
                        PlannedSprintView(platform: Platform(value: PlatformType.android),
                                          sprints: roadmap.sprints)
                    }
                }
            }.background(Color.white)
        }.background(Color.white)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct ProjectRoadmapView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectRoadmapView(projectName: "Demo Project",
                           roadmap: getDemoRoadmap())
            .frame(width: 1400, height: 1000, alignment: .center)
    }
}

private func getPlaceholderMonthView() -> some View {
    return HStack {
        Text("September").font(.system(size: 36, weight: .bold))
        Text("2021").font(.system(size: 36))
    }.padding()
}
