//
//  Sprint.swift
//  Planr
//
//  Created by Blakeman, Mike on 10/27/21.
//

import Foundation

struct Sprint {
    public private(set) var sprintId: NSUUID
    public private(set) var workBlocks: [WorkBlock]
    public private(set) var pointsRemaining: Int
    public private(set) var dateRange: DateInterval

    init(workBlocks: [WorkBlock], pointsRemaining: Int, dateRange: DateInterval) {
        self.sprintId = NSUUID()
        self.workBlocks = workBlocks
        self.pointsRemaining = pointsRemaining
        self.dateRange = dateRange
    }

    public mutating func addWorkBlock (_ workBlock: WorkBlock) {
        // If there aren't enough sprint points remaining do not add feature.
        guard workBlock.pointValue < pointsRemaining else {
            assertionFailure("Cannot add work block to sprint without enough remaining points.")
            return
        }

        var mutableWorkBlock = workBlock
        try? mutableWorkBlock.assignSprint(self.sprintId)

        self.decrementPointsRemaining(by: mutableWorkBlock.pointValue)
        self.workBlocks.append(mutableWorkBlock)
    }

    public mutating func decrementPointsRemaining (by points: Int) {
        guard points < self.pointsRemaining else {
            assertionFailure("Cannot decrease points by greater than points remaining")
            return
        }

        pointsRemaining -= points
    }
}
