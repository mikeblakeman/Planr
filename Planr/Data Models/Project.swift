//
//  Project.swift
//  Planr
//
//  Created by Blakeman, Mike on 8/25/21.
//

import Foundation

enum Platform {
    case ios
    case android
    case cocoas2dx
}

enum ProjectValidationError: Error {
    case invalidFeatureNameLengthError
    case invalidFeatureSummaryLengthError
    case featurePlatformEmptyError
    case duplicatePlatformError
    case effortEstimateTooHighError
    case priorityValueTooHighError
}

struct Project {
    private var name: String
    private(set) var features: [Feature]

    init(name: String, features: [Feature]) {
        self.name = name
        self.features = features
    }

    public mutating func addFeature(_ feature: Feature) {
        features.append(feature)
    }
}

struct Feature {
    private(set) var name: String
    private(set) var summary: String?
    private(set) var platform: [Platform]
    private(set) var effortEstimate: Int
    private(set) var priority: Int

    init(name: String, _ summary: String?, platform: [Platform], effortEstimate estimate: Int, priority: Int) {
        self.name = name
        self.summary = summary
        self.platform = platform
        self.effortEstimate = estimate
        self.priority = priority
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
