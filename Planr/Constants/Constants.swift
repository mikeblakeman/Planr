//
//  Constants.swift
//  Planr
//
//  Created by Blakeman, Mike on 8/25/21.
//

import Foundation

typealias GlobalConstants = Constants
class Constants {
    // Engineer name max character length
    static let engineerNameMaxLength = 40

    // Feature name max character length
    static let featureNameMaxLength = 40

    // Summary max character length
    static let summaryMaxCharacterLength = 240

    // Effort estimate max point value
    static let effortEstimateMaxPointValue = 120

    // TimeIntervals
    static let minute: TimeInterval = 60.0
    static let hour: TimeInterval = 60.0 * minute
    static let day: TimeInterval = 24 * hour
    static let week: TimeInterval = 7 * day
}
