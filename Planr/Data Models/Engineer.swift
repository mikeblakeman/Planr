//
//  Engineer.swift
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

enum EngineerValidationError: Swift.Error, Equatable, Hashable {
    case invalidFirstNameLength
    case invalidLastNameLength
    case invalidPlatformLength
    case invalidPlatformDuplicates
}

struct Engineer {
    private var firstName: String
    private var lastName: String
    private var platform: [Platform]
    private var unavailableDates: [Date]

    init(firstName: String, lastName: String, platform: [Platform], unavailableDates: [Date]) {
        self.firstName = firstName
        self.lastName = lastName
        self.platform = platform
        self.unavailableDates = unavailableDates
    }

    public func validate() throws -> Bool {
        if firstName.isEmpty || firstName.count > Constants.engineerNameMaxLength { throw EngineerValidationError.invalidFirstNameLength }
        if lastName.isEmpty || lastName.count > Constants.engineerNameMaxLength { throw EngineerValidationError.invalidLastNameLength }
        if platform.isEmpty { throw EngineerValidationError.invalidPlatformLength }
        if platform.count != Set(platform).count { throw EngineerValidationError.invalidPlatformDuplicates }
        return true
    }
}
