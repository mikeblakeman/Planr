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

struct WorkBlock: Hashable {
    public private(set) var name: String
    public private(set) var summary: String?
    public private(set) var platform: Platform
    public private(set) var pointValue: Int
    public private(set) var color: Color
    public private(set) var sprintId: NSUUID?
    public var isFinalSprint: Bool = false

    init (withPlannedFeature feature: PlannedFeature, pointValue: Int, platform: Platform, sprintId: NSUUID? = nil) {
        self.name = feature.name
        self.summary = feature.summary
        self.color = feature.color
        self.pointValue = pointValue
        self.platform = platform
        self.sprintId = sprintId
    }

    init (name: String, summary: String?, platform: Platform, pointValue: Int, color: Color, sprintId: NSUUID? = nil) {
        self.name = name
        self.summary = summary
        self.platform = platform
        self.pointValue = pointValue
        self.color = color
        self.sprintId = sprintId
    }

    public mutating func assignSprint(_ sprintId: NSUUID) throws {
        if self.sprintId != nil {
            throw WorkBlockValidationError.sprintAlreadyAssignedError
        }
        self.sprintId = sprintId
    }
    
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
