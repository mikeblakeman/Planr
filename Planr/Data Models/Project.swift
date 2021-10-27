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
