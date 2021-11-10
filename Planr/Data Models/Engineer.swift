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
class Engineer: Object {
    @Persisted(primaryKey: true) var engineerId: ObjectId
    @Persisted var firstName: String = ""
    @Persisted var lastName: String = ""
    @Persisted var platform: RealmSwift.List<Platform> = RealmSwift.List<Platform>()
    @Persisted var unavailableDates: RealmSwift.List<Date> = RealmSwift.List<Date>()

    /// Initializer
    ///
    /// - Parameter firstName: The engineer's first name.
    /// - Parameter lastName: The engineer's last name.
    /// - Parameter platform: A collection of `Platform` in which the engineer is proficient.
    /// - Parameter unavailableDates: A collection of `Date` in which the engineer is unavailable to work.
    init(firstName: String, lastName: String, platform: [PlatformType], unavailableDates: [Date]) {
        self.firstName = firstName
        self.lastName = lastName

        let platformList = List<Platform>()
        for iterator in platform {
            platformList.append(Platform(value: iterator))
        }
        self.platform = platformList

        let unavailableDateList = List<Date>()
        for date in unavailableDates {
            unavailableDateList.append(date)
        }
        self.unavailableDates = unavailableDateList
    }
}
