//
//  Feature.swift
//  Planr
//
//  Created by Blakeman, Mike on 10/26/21.
//

import Foundation
import SwiftUI

protocol PlanrFeature {
    var name: String { get }
    var summary: String? { get }
    var platform: [Platform] { get }
    var effortEstimate: Int { get }
    var priority: Int { get }
    var color: Color { get }
}

class UnplannedFeature: PlanrFeature {
    public private(set) var name: String
    public private(set) var summary: String?
    public private(set) var platform: [Platform]
    public private(set) var effortEstimate: Int
    public private(set) var priority: Int
    public private(set) var color: Color

    init(name: String, _ summary: String?, platform: [Platform], effortEstimate estimate: Int, priority: Int) {
        self.name = name
        self.summary = summary
        self.platform = platform
        self.effortEstimate = estimate
        self.priority = priority

        self.color = Color(Color.RGBColorSpace.sRGB,
                           red: .random(in: 0...1),
                           green: .random(in: 0...1),
                           blue: .random(in: 0...1))
    }

    public func updateName(_ name: String) throws {
        if name.isEmpty || name.count > Constants.featureNameMaxLength {
            throw ProjectValidationError.invalidFeatureNameLengthError
        }
    }

    public func updatePriority(_ priority: Int) throws {
        try validatePriority(priority)
    }

    public func validate() throws -> Bool {
        try validateName(name)
        try validateSummary(summary)
        try validatePlatform(platform)
        try validateEstimate(effortEstimate)
        try validatePriority(priority)
        return true
    }

    private func validateName(_ name: String) throws {
        if name.isEmpty || name.count > Constants.featureNameMaxLength {
            throw ProjectValidationError.invalidFeatureNameLengthError
        }
    }

    private func validateSummary(_ summary: String?) throws {
        if summary?.count ?? 0 > Constants.summaryMaxCharacterLength {
            throw ProjectValidationError.invalidFeatureSummaryLengthError
        }
    }

    private func validatePlatform(_ platform: [Platform]) throws {
        if platform.isEmpty { throw ProjectValidationError.featurePlatformEmptyError }
        if platform.count != Set(platform).count { throw ProjectValidationError.duplicatePlatformError }
    }

    private func validateEstimate(_ estimate: Int) throws {
        if effortEstimate > Constants.effortEstimateMaxPointValue {
            throw ProjectValidationError.effortEstimateTooHighError
        }
    }

    private func validatePriority(_ priority: Int) throws {
        if priority > 1000 {
            throw ProjectValidationError.priorityValueTooHighError
        }
    }
}

class PlannedFeature: PlanrFeature {
    public private(set) var name: String
    public private(set) var summary: String?
    public private(set) var platform: [Platform]
    public private(set) var effortEstimate: Int
    public private(set) var priority: Int
    public private(set) var color: Color

    public private(set) var sprintId: NSUUID
    public private(set) var sprintPoints: Int
    public private(set) var isFinalSprint: Bool

    init (withUnplannedFeature feature: UnplannedFeature, sprintPoints: Int, isFinalSprint: Bool) {
        self.name = feature.name
        self.summary = feature.summary
        self.platform = feature.platform
        self.effortEstimate = feature.effortEstimate
        self.priority = feature.priority
        self.color = feature.color

        self.sprintId = NSUUID()
        self.sprintPoints = sprintPoints
        self.isFinalSprint = isFinalSprint
    }
}
