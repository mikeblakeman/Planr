//
//  PlatformSprintBlockView.swift
//  Planr
//
//  Created by Blakeman, Mike on 11/7/21.
//

import SwiftUI

struct PlatformSprintBlockView: View, Identifiable {

    private var dateRange: DateInterval
    private var workBlocks: [WorkBlock]
    private var sprintPointsRemaining: Int
    var id = UUID()

    init(dateRange: DateInterval,
         workBlocks: [WorkBlock],
         sprintPointsRemaining: Int) {
        self.dateRange = dateRange
        self.workBlocks = workBlocks
        self.sprintPointsRemaining = sprintPointsRemaining
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            getDateView(dateRange: self.dateRange)
            ForEach(self.workBlocks, id: \.self) { workBlock in
                WorkBlockView(workBlock: workBlock)
            }
            Spacer()
            getPointsRemainingView(sprintPointsRemaining: self.sprintPointsRemaining)
        }.frame(minWidth: 300, maxWidth: .infinity, minHeight: 260, maxHeight: .infinity)
        .padding(5)
        .border(Color.black)
        .background(Color.white)
    }

    func getDateView(dateRange: DateInterval) -> some View {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd"

        return Text("\(dateFormatter.string(from: dateRange.start)) - " +
                        "\(dateFormatter.string(from: dateRange.end))")
            .font(.system(size: 14))
            .padding(.vertical, 5)
    }
}

struct PlatformSprintBlockView_Previews: PreviewProvider {
    static var previews: some View {
        let sprint = getDemoSprint()
        let iosWorkBlocks = sprint.workBlocksForPlatform(.ios)
        PlatformSprintBlockView(dateRange: sprint.dateRange,
                                workBlocks: iosWorkBlocks,
                                sprintPointsRemaining: sprint.pointsRemaining)
    }
}

private func getPointsRemainingView(sprintPointsRemaining: Int) -> some View {
    let workBlock = WorkBlock(name: "Points Remaining",
                              summary: nil,
                              platform: .ios,
                              pointValue: sprintPointsRemaining,
                              color: .gray)
    return WorkBlockView(workBlock: workBlock)
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
                               platform: .ios,
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
