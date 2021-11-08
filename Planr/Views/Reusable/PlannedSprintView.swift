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
            Text(platform.rawValue)
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
        let data = getDemoData()
        PlannedSprintView(platform: data.0, sprints: data.1)
    }
}

private func getDemoData() -> (Platform, [Sprint]) {
    return (.ios, [getDemoSprint(), getDemoSprint(), getDemoSprint(), getDemoSprint()])
}

private func getDemoSprint() -> Sprint {
    var workBlock1 = WorkBlock(name: "Family Account",
                               summary: "This is a cool family account features.",
                               platform: .ios,
                               pointValue: 8,
                               color: randomColor())

    workBlock1.isFinalSprint = true

    let workBlock2 = WorkBlock(name: "Device Setup",
                               summary: "A feature that covers setting up a device.",
                               platform: .android,
                               pointValue: 3,
                               color: randomColor())

    let now = Date()
    let nextWeek = now.addingTimeInterval(7.0 * 24.0 * 3600.0)
    let dateInterval = DateInterval(start: now, end: nextWeek)

    let sprint = Sprint(workBlocks: [workBlock1, workBlock2],
                        pointsRemaining: 8,
                        dateRange: dateInterval)
    return sprint
}
