//
//  WorkBlock.swift
//  Planr
//
//  Created by Blakeman, Mike on 11/1/21.
//

import Foundation
import SwiftUI

enum WorkBlockValidationError: Error {
    case sprintAlreadyAssignedError
    case engineerAlreadyAssignedError
    case engineerProficiencyError
}

/// A representation of a block of work inside a given sprint.
struct WorkBlock: Hashable {
    public private(set) var name: String
    public private(set) var summary: String?
    public private(set) var platform: Platform
    public private(set) var pointValue: Int
    public private(set) var color: Color
    public private(set) var sprintId: NSUUID?
    public var isFinalSprint: Bool = false

    /// Initializer
    ///
    /// - Parameter feature: A `PlannedFeature` that is assigned to this work block.
    /// - Parameter pointValue: The total point value for this work block.
    /// - Parameter platform: The `Platform` that is associated with the feature and work block.
    /// - Parameter sprintId: An optional `NSUUID` that allows the sprint's unique ID to be passed in.
    init (withPlannedFeature feature: PlannedFeature, pointValue: Int, platform: Platform, sprintId: NSUUID? = nil) {
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
    /// - Parameter color: The color of the work block / feature.
    /// - Parameter sprintId: An optional `NSUUID` that allows the sprint's unique ID to be passed in.
    init (name: String, summary: String?, platform: Platform, pointValue: Int, color: Color, sprintId: NSUUID? = nil) {
        self.name = name
        self.summary = summary
        self.platform = platform
        self.pointValue = pointValue
        self.color = color
        self.sprintId = sprintId
    }

    /// This method mutates the work block to assign the sprint.
    ///
    /// - Parameter sprintId: The `NSUUID` or GUID to uniquely identify the sprint.
    public mutating func assignSprint(_ sprintId: NSUUID) throws {
        if self.sprintId != nil {
            throw WorkBlockValidationError.sprintAlreadyAssignedError
        }
        self.sprintId = sprintId
    }

    // Hashable protocol conforming methods.
    static func == (lhs: WorkBlock, rhs: WorkBlock) -> Bool {
        return lhs.name == rhs.name
            && lhs.summary == rhs.summary
            && lhs.platform == rhs.platform
            && lhs.pointValue == rhs.pointValue
            && lhs.color == rhs.color
            && lhs.sprintId == rhs.sprintId
            && lhs.isFinalSprint == rhs.isFinalSprint
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(summary)
        hasher.combine(platform)
        hasher.combine(pointValue)
        hasher.combine(color)
        hasher.combine(sprintId)
        hasher.combine(isFinalSprint)
    }
}
