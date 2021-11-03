//
//  Sprint.swift
//  Planr
//
//  Created by Blakeman, Mike on 10/27/21.
//

import Foundation

/// A structure that represents an Agile Sprint
struct Sprint {
    public private(set) var sprintId: NSUUID
    public private(set) var workBlocks: [WorkBlock]
    public private(set) var pointsRemaining: Int
    public private(set) var dateRange: DateInterval
    private var initialSprintPoints: Int

    /// Initializer
    ///
    /// - Parameter workBlocks: A collection of `WorkBlock`
    /// - Parameter pointsRemaining: The number of points remaining to plan in a given `Sprint`
    /// - Parameter dateRange: A `DateInterval` for the given `Sprint`
    init(workBlocks: [WorkBlock], pointsRemaining: Int, dateRange: DateInterval) {
        self.sprintId = NSUUID()
        self.workBlocks = workBlocks
        self.pointsRemaining = pointsRemaining
        self.dateRange = dateRange
        self.initialSprintPoints = pointsRemaining
    }

    /// Use this method to add planned `WorkBlock`s to the current `Sprint`
    ///
    /// - Parameter workBlock: A  planned `WorkBlock`
    /// - Note: This will mutate the collection of `WorkBlock`
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

    /// Decrease points remaining in current `Sprint`
    ///
    /// - Parameter points: Points in `Int` to decrease the remaining
    private mutating func decrementPointsRemaining (by points: Int) {
        guard points < self.pointsRemaining else {
            assertionFailure("Cannot decrease points by greater than points remaining")
            return
        }

        pointsRemaining -= points
    }

    /// Debug print function
    ///
    /// Use this method to print information about the sprint in question.
    public func printSprintInfo() {
        print("------------------------------------------------------------")
        print("Sprint Start Date: \(self.dateRange.start)\nSprint End Date:   \(self.dateRange.end)\n")
        print("\nTotal Sprint Points: \(self.initialSprintPoints)")
        print(" List of features in sprint:")
        for workBlock in self.workBlocks {
            print("    Title: \(workBlock.name)" +
                  " - Platform: \(workBlock.platform.rawValue)" +
                  " - Points: \(workBlock.pointValue)")
        }
        print("Total Sprint Points Remaining: \(self.pointsRemaining)")
    }
}
