//
//  PlatformSprintBlockView.swift
//  Planr
//
//  Created by Blakeman, Mike on 11/7/21.
//

import SwiftUI

/// A view that represents a planned `Sprint`.
///
/// This view contains the work blocks for the `Sprint`, the remaining points work block, and the date of the sprint.
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

    private func getDateView(dateRange: DateInterval) -> some View {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd"

        return Text("\(dateFormatter.string(from: dateRange.start)) - " +
                        "\(dateFormatter.string(from: dateRange.end))")
            .font(.system(size: 14))
            .padding(.vertical, 5)
    }

    private func getPointsRemainingView(sprintPointsRemaining: Int) -> some View {
        let workBlock = WorkBlock(name: "Points Remaining",
                                  summary: nil,
                                  platform: Platform.ios,
                                  pointValue: sprintPointsRemaining,
                                  color: Color.gray)
        return WorkBlockView(workBlock: workBlock)
    }
}

struct PlatformSprintBlockView_Previews: PreviewProvider {
    static var previews: some View {
        let sprint = getDemoSprint()
        let iosWorkBlocks = sprint.workBlocksForPlatform(Platform.ios)
        PlatformSprintBlockView(dateRange: sprint.dateRange,
                                workBlocks: iosWorkBlocks,
                                sprintPointsRemaining: sprint.pointsRemaining)
    }
}
