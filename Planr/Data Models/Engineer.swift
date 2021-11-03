//
//  Engineer.swift
//  Planr
//
//  Created by Blakeman, Mike on 8/25/21.
//

import Foundation

enum EngineerValidationError: Error {
    case invalidFirstNameLength
    case invalidLastNameLength
    case invalidPlatformLength
    case invalidPlatformDuplicates
    case invalidUnavailableDate
}

/// A representation of an Engineer for planning purposes.
struct Engineer: Hashable {
    public private(set) var firstName: String
    public private(set) var lastName: String
    public private(set) var platform: [Platform]
    public private(set) var unavailableDates: [Date]

    /// Initializer
    ///
    /// - Parameter firstName: The engineer's first name.
    /// - Parameter lastName: The engineer's last name.
    /// - Parameter platform: A collection of `Platform` in which the engineer is proficient.
    /// - Parameter unavailableDates: A collection of `Date` in which the engineer is unavailable to work.
    init(firstName: String, lastName: String, platform: [Platform], unavailableDates: [Date]) {
        self.firstName = firstName
        self.lastName = lastName
        self.platform = platform
        self.unavailableDates = unavailableDates
    }

    /// A helper functiont to validate the data that was input.
    ///
    /// - Returns: A `Bool` indicating the validation either did or did not pass.
    public func validate() throws -> Bool {
        try validateFirstName(firstName)
        try validateLastName(lastName)
        try validatePlatform(platform)
        try validateUnavailableDates(unavailableDates)
        return true
    }

    private func validateFirstName(_ name: String) throws {
        if firstName.isEmpty || firstName.count > Constants.engineerNameMaxLength {
            throw EngineerValidationError.invalidFirstNameLength
        }
    }

    private func validateLastName(_ name: String) throws {
        if lastName.isEmpty || lastName.count > Constants.engineerNameMaxLength {
            throw EngineerValidationError.invalidLastNameLength
        }
    }

    private func validatePlatform(_ platform: [Platform]) throws {
        if platform.isEmpty { throw EngineerValidationError.invalidPlatformLength }
        if platform.count != Set(platform).count { throw EngineerValidationError.invalidPlatformDuplicates }
    }

    private func validateUnavailableDates(_ dates: [Date]) throws {
        if !(dates.allSatisfy { Calendar.current.isDateInToday($0) || $0.timeIntervalSinceNow.sign == .plus }) {
            throw EngineerValidationError.invalidUnavailableDate
        }
    }

    // Hashable protocol conforming method.
    static func == (lhs: Engineer, rhs: Engineer) -> Bool {
        return lhs.firstName == rhs.firstName
            && lhs.lastName == rhs.lastName
            && lhs.platform == rhs.platform
            && lhs.unavailableDates == rhs.unavailableDates
    }
}
