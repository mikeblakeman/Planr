//
//  Engineer.swift
//  Planr
//
//  Created by Blakeman, Mike on 8/25/21.
//

import Foundation
import RealmSwift

enum EngineerValidationError: Error {
    case invalidFirstNameLength
    case invalidLastNameLength
    case invalidPlatformLength
    case invalidPlatformDuplicates
    case invalidUnavailableDate
}

/// A representation of an Engineer for planning purposes.
class Engineer: Hashable {
    public private(set) var engineerId: ObjectId = ObjectId()
    public private(set) var firstName: String = ""
    public private(set) var lastName: String = ""
    public private(set) var platform: [Platform] = []
    public private(set) var unavailableDates: [Date] = []

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

    init(withRealmEngineer engineer: RealmEngineer) {
        self.engineerId = engineer.engineerId
        self.firstName = engineer.firstName
        self.lastName = engineer.lastName
        var platforms: [Platform] = []
        engineer.platform.forEach {
            if let platform = Platform(rawValue: $0) {
                platforms.append(platform)
            }
        }
        self.platform = platforms
        self.unavailableDates = Array(engineer.unavailableDates)
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(engineerId)
        hasher.combine(firstName)
        hasher.combine(lastName)
    }

    static func == (lhs: Engineer, rhs: Engineer) -> Bool {
        return lhs.engineerId == rhs.engineerId &&
            lhs.firstName == rhs.firstName &&
            lhs.lastName == rhs.lastName &&
            lhs.platform == rhs.platform &&
            lhs.unavailableDates == rhs.unavailableDates
    }
}

class RealmEngineer: Object {
    @Persisted(primaryKey: true) var engineerId: ObjectId
    @Persisted var firstName: String = ""
    @Persisted var lastName: String = ""
    @Persisted var platform: RealmSwift.List<Int> = RealmSwift.List<Int>()
    @Persisted var unavailableDates: RealmSwift.List<Date> = RealmSwift.List<Date>()
}
