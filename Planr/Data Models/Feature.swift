//
//  Feature.swift
//  Planr
//
//  Created by Blakeman, Mike on 10/26/21.
//

import Foundation
import SwiftUI

/// Common interface for `UnplannedFeature` and `PlannedFeature` classes
protocol PlanrFeature: Hashable {
    var name: String { get }
    var summary: String? { get }
    var platform: [Platform] { get }
    var effortEstimate: Int { get }
    var priority: Int { get }
    var concurrencyAllowed: Bool { get }
    var color: Color { get }
}

enum FeatureValidationError: Error {
    case invalidFeatureNameLengthError
    case invalidFeatureSummaryLengthError
    case featurePlatformEmptyError
    case duplicatePlatformError
    case effortEstimateTooHighError
    case priorityValueTooHighError
    case engineerAlreadyAssignedError
}

/// A class that conforms to the `PlanrFeature` protocol that represents an unplanned feature.
class UnplannedFeature: PlanrFeature {

    public private(set) var name: String
    public private(set) var summary: String?
    public private(set) var platform: [Platform]
    public private(set) var effortEstimate: Int
    public private(set) var priority: Int
    public private(set) var concurrencyAllowed: Bool
    public private(set) var color: Color

    /// Initializer
    ///
    /// - Parameter name: A `String` representing the name of the feature to be worked on.
    /// - Parameter summary: An optional `String` to provide more context about the feature.
    /// - Parameter platform: A collection of `Platform`s which the feature is to be developed for.
    /// - Parameter effortEstimate: An `Int` of the estimated points for the feature per platform.
    /// - Parameter priority: An `Int` representation of the prioritiy of the feature on a scale from 0 to 1000.
    /// - Parameter concurrencyAllowed: A `Bool` to determine if the feature can be worked on concurrently by two developers.
    init(name: String,
         _ summary: String?,
         platform: [Platform],
         effortEstimate estimate: Int,
         priority: Int,
         concurrencyAllowed: Bool = false) {
        self.name = name
        self.summary = summary
        self.platform = platform
        self.effortEstimate = estimate
        self.priority = priority
        self.concurrencyAllowed = concurrencyAllowed

        self.color = Color(Color.RGBColorSpace.sRGB,
                           red: .random(in: 0...1),
                           green: .random(in: 0...1),
                           blue: .random(in: 0...1))
    }

    /// Function to update the name of the feature.
    ///
    /// - Parameter name: A passed in `String` that updates the name of the `UnplannedFeature`.
    public func updateName(_ name: String) throws {
        if name.isEmpty || name.count > Constants.featureNameMaxLength {
            throw FeatureValidationError.invalidFeatureNameLengthError
        }
    }

    /// Function to update the priority of the feature.
    ///
    /// - Parameter priority: An integer value that updates the priority of the `UnplannedFeature`.
    public func updatePriority(_ priority: Int) throws {
        try validatePriority(priority)
    }

    /// Function to validae the current state of the `UnplannedFeature`.
    ///
    /// - Note: This helps in unit testing.
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
            throw FeatureValidationError.invalidFeatureNameLengthError
        }
    }

    private func validateSummary(_ summary: String?) throws {
        if summary?.count ?? 0 > Constants.summaryMaxCharacterLength {
            throw FeatureValidationError.invalidFeatureSummaryLengthError
        }
    }

    private func validatePlatform(_ platform: [Platform]) throws {
        if platform.isEmpty { throw FeatureValidationError.featurePlatformEmptyError }
        if platform.count != Set(platform).count { throw FeatureValidationError.duplicatePlatformError }
    }

    private func validateEstimate(_ estimate: Int) throws {
        if effortEstimate > Constants.effortEstimateMaxPointValue {
            throw FeatureValidationError.effortEstimateTooHighError
        }
    }

    private func validatePriority(_ priority: Int) throws {
        if priority > 1000 {
            throw FeatureValidationError.priorityValueTooHighError
        }
    }

    // Hashable protocol method
    static func == (lhs: UnplannedFeature, rhs: UnplannedFeature) -> Bool {
        return lhs.name == rhs.name
            && lhs.summary == rhs.summary
            && lhs.platform == rhs.platform
            && lhs.effortEstimate == rhs.effortEstimate
            && lhs.priority == rhs.priority
            && lhs.concurrencyAllowed == rhs.concurrencyAllowed
            && lhs.color == rhs.color
    }

    // Hashable protocol method
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(summary)
        hasher.combine(platform)
        hasher.combine(effortEstimate)
        hasher.combine(priority)
        hasher.combine(concurrencyAllowed)
        hasher.combine(color)
    }
}

/// A class that conforms to the `PlanrFeature` protocol that represents a planned feature.
class PlannedFeature: PlanrFeature, Hashable {
    public private(set) var name: String
    public private(set) var summary: String?
    public private(set) var platform: [Platform]
    public private(set) var effortEstimate: Int
    public private(set) var priority: Int
    public private(set) var concurrencyAllowed: Bool
    public private(set) var color: Color

    public private(set) var workBlocks: [WorkBlock] = []

    public var isFinalSprint: Bool = false

    init (withUnplannedFeature feature: UnplannedFeature, averageVelocity: Int) {
        self.name = feature.name
        self.summary = feature.summary
        self.platform = feature.platform
        self.effortEstimate = feature.effortEstimate
        self.priority = feature.priority
        self.concurrencyAllowed = feature.concurrencyAllowed
        self.color = feature.color

        // Generate WorkBlocks per platform
        for platform in feature.platform {
            let workBlockCount = self.effortEstimate / averageVelocity
            if workBlockCount > 0 {
                for _ in 1...workBlockCount {
                    let workBlock = WorkBlock(name: feature.name,
                                              summary: feature.summary,
                                              platform: platform,
                                              pointValue: averageVelocity,
                                              color: feature.color)
                    self.workBlocks.append(workBlock)
                }
            }

            let remainder = self.effortEstimate % averageVelocity
            if (self.effortEstimate % averageVelocity) > 0 {
                let workBlock = WorkBlock(name: feature.name,
                                          summary: feature.summary,
                                          platform: platform,
                                          pointValue: remainder,
                                          color: feature.color)
                self.workBlocks.append(workBlock)
            }
        }
    }

    public func assignWorkBlock(_ workBlock: WorkBlock) {
        guard let index = workBlocks.firstIndex(where: { $0.pointValue == workBlock.pointValue
                                                    && $0.platform == workBlock.platform
                                                    && $0.sprintId == nil }) else {
            return
        }

        workBlocks[index] = workBlock
    }

    public func nextUnassignedWorkBlockForPlatform(platform: Platform) -> WorkBlock? {
        return self.workBlocks.first(where: { $0.sprintId == nil && $0.platform == platform })
    }

    static func == (lhs: PlannedFeature, rhs: PlannedFeature) -> Bool {
        return lhs.name == rhs.name
            && lhs.summary == rhs.summary
            && lhs.platform == rhs.platform
            && lhs.effortEstimate == rhs.effortEstimate
            && lhs.priority == rhs.priority
            && lhs.concurrencyAllowed == rhs.concurrencyAllowed
            && lhs.color == rhs.color
            && lhs.workBlocks == rhs.workBlocks
            && lhs.isFinalSprint == rhs.isFinalSprint
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(summary)
        hasher.combine(platform)
        hasher.combine(effortEstimate)
        hasher.combine(priority)
        hasher.combine(concurrencyAllowed)
        hasher.combine(color)
        hasher.combine(workBlocks)
        hasher.combine(isFinalSprint)
    }
}
