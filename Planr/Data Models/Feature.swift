//
//  Feature.swift
//  Planr
//
//  Created by Blakeman, Mike on 10/26/21.
//

import Foundation
import RealmSwift
import SwiftUI

/// Common interface for `UnplannedFeature` and `PlannedFeature` classes
protocol PlanrFeature: Object {
    var name: String { get }
    var summary: String? { get }
    var platform: RealmSwift.List<Platform> { get }
    var effortEstimate: Int { get }
    var priority: Int { get }
    var concurrencyAllowed: Bool { get }
    var color: RealmColor { get }
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
class UnplannedFeature: Object, PlanrFeature {

    @Persisted(primaryKey: true) var featureId: ObjectId
    @Persisted var name: String = ""
    @Persisted var summary: String?
    @Persisted var platform: RealmSwift.List<Platform> = RealmSwift.List<Platform>()
    @Persisted var effortEstimate: Int = 0
    @Persisted var priority: Int = 0
    @Persisted var concurrencyAllowed: Bool = false
    @Persisted var color: RealmColor

    /// Initializer
    ///
    /// - Parameter name: A `String` representing the name of the feature to be worked on.
    /// - Parameter summary: An optional `String` to provide more context about the feature.
    /// - Parameter platform: A collection of `Platform`s which the feature is to be developed for.
    /// - Parameter effortEstimate: An `Int` of the estimated points for the feature per platform.
    /// - Parameter priority: An `Int` representation of the prioritiy of the feature on a scale from 0 to 1000.
    /// - Parameter concurrencyAllowed: A `Bool` to determine if the feature can be worked on concurrently.
    init(name: String,
         _ summary: String?,
         platform: [PlatformType],
         effortEstimate estimate: Int,
         priority: Int,
         concurrencyAllowed: Bool = false) {
        super.init()
        self.name = name
        self.summary = summary

        for type in platform {
            self.platform.append(Platform(value: type))
        }

        self.effortEstimate = estimate
        self.priority = priority
        self.concurrencyAllowed = concurrencyAllowed

        self.color = RealmColor(withColor: Color(Color.RGBColorSpace.sRGB,
                                                 red: .random(in: 0...1),
                                                 green: .random(in: 0...1),
                                                 blue: .random(in: 0...1)))
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
        let numberRange = 0...1000
        if !numberRange.contains(priority) {
            throw FeatureValidationError.priorityValueTooHighError
        }
    }
}

/// A class that conforms to the `PlanrFeature` protocol that represents a planned feature.
class PlannedFeature: Object, PlanrFeature {
    @Persisted(primaryKey: true) var featureId: ObjectId
    @Persisted var name: String = ""
    @Persisted var summary: String?
    @Persisted var platform: RealmSwift.List<Platform> = RealmSwift.List<Platform>()
    @Persisted var effortEstimate: Int = 0
    @Persisted var priority: Int = 0
    @Persisted var concurrencyAllowed: Bool = false
    @Persisted var color: RealmColor

    public private(set) var workBlocks: [WorkBlock] = []

    init (withUnplannedFeature feature: UnplannedFeature, averageVelocity: Int) {
        super.init()
        self.name = feature.name
        self.summary = feature.summary
        self.platform = feature.platform
        self.effortEstimate = feature.effortEstimate
        self.priority = feature.priority
        self.concurrencyAllowed = feature.concurrencyAllowed
        self.color = feature.color
        self.featureId = feature.featureId

        // Generate WorkBlocks per platform
        for platform in feature.platform {
            let workBlockCount = self.effortEstimate / averageVelocity
            if workBlockCount > 0 {
                for _ in 1...workBlockCount {
                    let workBlock = WorkBlock(name: feature.name,
                                              summary: feature.summary,
                                              platform: platform,
                                              pointValue: averageVelocity,
                                              color: feature.color,
                                              sprintId: nil)
                    self.workBlocks.append(workBlock)
                }
            }

            let remainder = self.effortEstimate % averageVelocity
            if (self.effortEstimate % averageVelocity) > 0 {
                let workBlock = WorkBlock(name: feature.name,
                                          summary: feature.summary,
                                          platform: platform,
                                          pointValue: remainder,
                                          color: feature.color,
                                          sprintId: nil)
                self.workBlocks.append(workBlock)
            }
        }
    }

    /// A method to assign work blocks to the given feature.
    ///
    /// - Parameter workBlock: The `WorkBlock` to assign to a planned feature.
    public func assignWorkBlock(_ workBlock: WorkBlock) {
        // Get the index of the first unassigned work block with the same point value and platform.
        guard let index = workBlocks.firstIndex(where: { $0.pointValue == workBlock.pointValue
                                                    && $0.platform == workBlock.platform
                                                    && $0.sprintId == nil }) else {
            return
        }

        workBlocks[index] = workBlock
    }

    /// A method to get the next unassigned work block.
    ///
    /// - Parameter platform: The `Platform` to match the unassigned work block.
    public func nextUnassignedWorkBlockForPlatform(platform: Platform) -> WorkBlock? {
        return self.workBlocks.first(where: { $0.sprintId == nil && $0.platform == platform })
    }
}
