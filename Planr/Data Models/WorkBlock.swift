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
struct WorkBlock: Hashable, Identifiable {
    public private(set) var name: String
    public private(set) var summary: String?
    public private(set) var platform: Platform
    public private(set) var pointValue: Int
    public private(set) var color: Color
    public private(set) var id: UUID?
    public var isFinalSprint: Bool = false

    /// Initializer
    ///
    /// - Parameter feature: A `PlannedFeature` that is assigned to this work block.
    /// - Parameter pointValue: The total point value for this work block.
    /// - Parameter platform: The `Platform` that is associated with the feature and work block.
    /// - Parameter id: An optional `UUID` that allows the sprint's unique ID to be passed in.
    init (withPlannedFeature feature: PlannedFeature, pointValue: Int, platform: Platform, id: UUID? = nil) {
        self.init(name: feature.name,
                  summary: feature.summary,
                  platform: platform,
                  pointValue: pointValue,
                  color: feature.color,
                  id: id)
    }

    /// Initializer
    ///
    /// - Parameter name: Name of the feature in the work block.
    /// - Parameter summary: Summary of the feature in the work block.
    /// - Parameter platform: The `Platform` that is associated with the feature and work block.
    /// - Parameter pointValue: The total point value for this work block.
    /// - Parameter color: The color of the work block / feature.
    /// - Parameter id: An optional `NSUUID` that allows the sprint's unique ID to be passed in.
    init (name: String, summary: String?, platform: Platform, pointValue: Int, color: Color, id: UUID? = nil) {
        self.name = name
        self.summary = summary
        self.platform = platform
        self.pointValue = pointValue
        self.color = color
        self.id = id
    }

    /// This method mutates the work block to assign the sprint.
    ///
    /// - Parameter sprintId: The `NSUUID` or GUID to uniquely identify the sprint.
    public mutating func assignSprint(_ id: UUID) throws {
        if self.id != nil {
            throw WorkBlockValidationError.sprintAlreadyAssignedError
        }
        self.id = id
    }

    // Hashable protocol conforming methods.
    static func == (lhs: WorkBlock, rhs: WorkBlock) -> Bool {
        return lhs.name == rhs.name
            && lhs.summary == rhs.summary
            && lhs.platform == rhs.platform
            && lhs.pointValue == rhs.pointValue
            && lhs.color == rhs.color
            && lhs.id == rhs.id
            && lhs.isFinalSprint == rhs.isFinalSprint
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(summary)
        hasher.combine(platform)
        hasher.combine(pointValue)
        hasher.combine(color)
        hasher.combine(id)
        hasher.combine(isFinalSprint)
    }
}
