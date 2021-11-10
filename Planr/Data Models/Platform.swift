//
//  Platform.swift
//  Planr
//
//  Created by Blakeman, Mike on 10/29/21.
//

import Foundation
import RealmSwift

/// An enumeration of platforms to be assigned to work on.
enum PlatformType: String, CaseIterable {
    case ios = "iOS"
    case android = "Android"
    case cocoas2dx = "Cocoas2dx"
}

extension PlatformType: RealmEnum { }

/// A represntation of the enum `PlatformType` used for storage in Realm database.
class Platform: Object, Decodable {
    @Persisted private var privateType: String = PlatformType.ios.rawValue

     var type: PlatformType {
        get { return PlatformType(rawValue: privateType)! }
        set { privateType = newValue.rawValue }
    }
}
