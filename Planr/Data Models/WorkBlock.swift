//
//  WorkBlock.swift
//  Planr
//
//  Created by Blakeman, Mike on 11/1/21.
//

import Foundation
import SwiftUI
import RealmSwift

enum WorkBlockValidationError: Error {
    case sprintAlreadyAssignedError
    case engineerAlreadyAssignedError
    case engineerProficiencyError
}

/// A representation of a block of work inside a given sprint.
class WorkBlock: Object {
    @Persisted(primaryKey: true) var workBlockId: ObjectId
    @Persisted var name: String = ""
    @Persisted var summary: String?
    @Persisted var platform: Platform
    @Persisted var pointValue: Int
    @Persisted var color: RealmColor
    @Persisted var isFinalSprint: Bool = false
    @Persisted var sprintId: ObjectId?

    /// Initializer
    ///
    /// - Parameter feature: A `PlannedFeature` that is assigned to this work block.
    /// - Parameter pointValue: The total point value for this work block.
    /// - Parameter platform: The `Platform` that is associated with the feature and work block.
    /// - Parameter sprintId: An optional `UUID` that allows the sprint's unique ID to be passed in.
    convenience init (withPlannedFeature feature: PlannedFeature,
                      pointValue: Int,
                      platform: Platform,
                      sprintId: ObjectId? = nil) {
        self.init(name: feature.name,
                  summary: feature.summary,
                  platform: platform,
                  pointValue: pointValue,
                  color: feature.color,
                  sprintId: sprintId)
    }

    /// Initializer
    ///
    /// - Parameter name: Name of the feature in the work block.
    /// - Parameter summary: Summary of the feature in the work block.
    /// - Parameter platform: The `Platform` that is associated with the feature and work block.
    /// - Parameter pointValue: The total point value for this work block.
    /// - Parameter realmColor: The color of the work block / feature.
    /// - Parameter sprintId: An optional `ObjectId` that allows the sprint's unique ID to be passed in.
    init (name: String,
          summary: String?,
          platform: Platform,
          pointValue: Int,
          color: RealmColor,
          sprintId: ObjectId? = nil) {
        self.name = name
        self.summary = summary
        self.platform = platform
        self.pointValue = pointValue
        self.color = color
        self.sprintId = sprintId
    }
}
