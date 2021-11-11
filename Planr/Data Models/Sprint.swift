//
//  Sprint.swift
//  Planr
//
//  Created by Blakeman, Mike on 10/27/21.
//

import Foundation
import RealmSwift

/// A structure that represents an Agile Sprint
class Sprint {
    public private(set) var sprintId: ObjectId = ObjectId()
    public private(set) var workBlockDictionary: [Platform: [WorkBlock]]
    public private(set) var pointsRemaining: Int
    public private(set) var dateRange: DateInterval
    private var initialSprintPoints: Int

    /// Initializer
    ///
    /// - Parameter workBlocks: A collection of `WorkBlock`
    /// - Parameter pointsRemaining: The number of points remaining to plan in a given `Sprint`
    /// - Parameter dateRange: A `DateInterval` for the given `Sprint`
    init(workBlocks: [WorkBlock], pointsRemaining: Int, dateRange: DateInterval) {
        self.workBlockDictionary = [:]
        self.pointsRemaining = pointsRemaining
        self.dateRange = dateRange
        self.initialSprintPoints = pointsRemaining

        for block in workBlocks {
            if var collection = workBlockDictionary[block.platform] {
                collection.append(block)
                workBlockDictionary[block.platform] = collection
            } else {
                workBlockDictionary[block.platform] = [block]
            }
        }
    }

    /// Use this method to add planned `WorkBlock`s to the current `Sprint`
    ///
    /// - Parameter workBlock: A  planned `WorkBlock`
    /// - Note: This will mutate the collection of `WorkBlock`
    public func addWorkBlock (_ workBlock: WorkBlock) {
        // If there aren't enough sprint points remaining do not add feature.
        guard workBlock.pointValue < pointsRemaining else {
            assertionFailure("Cannot add work block to sprint without enough remaining points.")
            return
        }

        workBlock.sprintId = self.sprintId

        self.decrementPointsRemaining(by: workBlock.pointValue)
        if var collection = workBlockDictionary[workBlock.platform] {
            collection.append(workBlock)
            workBlockDictionary[workBlock.platform] = collection
        } else {
            workBlockDictionary[workBlock.platform] = [workBlock]
        }
    }

    /// User this method to get all `WorkBlock`s for a given platform
    ///
    /// - Parameter platform: A `Platform`.
    public func workBlocksForPlatform(_ platform: Platform) -> [WorkBlock] {
        return self.workBlockDictionary[platform] ?? []
    }

    /// Debug print function
    ///
    /// Use this method to print information about the sprint in question.
    public func printSprintInfo() {
        print("------------------------------------------------------------")
        print("Sprint Start Date: \(self.dateRange.start)\nSprint End Date:   \(self.dateRange.end)\n")
        print("\nTotal Sprint Points: \(self.initialSprintPoints)")
        for key in self.workBlockDictionary.keys {
            print(" List of \(key.rawValue) features in sprint:")
            guard let collection = self.workBlockDictionary[key] else {
                return
            }

            for workBlock in collection {
                print("    Title: \(workBlock.name)" +
                        " - Platform: \(workBlock.platform.rawValue)" +
                        " - Points: \(workBlock.pointValue)")
            }
        }
        print("Total Sprint Points Remaining: \(self.pointsRemaining)")
    }

    /// Decrease points remaining in current `Sprint`
    ///
    /// - Parameter points: Points in `Int` to decrease the remaining
    private func decrementPointsRemaining (by points: Int) {
        guard points < self.pointsRemaining else {
            assertionFailure("Cannot decrease points by greater than points remaining")
            return
        }

        pointsRemaining -= points
    }
}
