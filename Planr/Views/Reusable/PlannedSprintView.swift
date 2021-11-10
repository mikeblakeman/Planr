//
//  PlannedSprintView.swift
//  Planr
//
//  Created by Blakeman, Mike on 11/7/21.
//

import SwiftUI

struct PlannedSprintView: View {

    private var platform: Platform
    private var sprints: [Sprint]

    init(platform: Platform, sprints: [Sprint]) {
        self.platform = platform
        self.sprints = sprints
    }

    var body: some View {
        VStack(spacing: 0) {
            Text(platform.type.rawValue)
                .font(.system(size: 24))
                .foregroundColor(.white)
                .padding(5)
            HStack(alignment: .center, spacing: 0) {
                ForEach(getViews()) { view in
                    view
                }
            }
        }.background(Constants.lightGrayColor).border(Color.black)
    }

    private func getViews() -> [PlatformSprintBlockView] {
        var viewCollection = [PlatformSprintBlockView]()
        for sprint in self.sprints {
            viewCollection.append(PlatformSprintBlockView(dateRange: sprint.dateRange,
                                                          workBlocks: sprint.workBlocksForPlatform(platform),
                                                          sprintPointsRemaining: sprint.pointsRemaining))
        }
        return viewCollection
    }
}

struct PlannedSprintView_Previews: PreviewProvider {
    static var previews: some View {
        PlannedSprintView(platform: Platform(value: PlatformType.ios),
                          sprints: getDemoRoadmap().sprints)
    }
}
