//
//  Platform.swift
//  Planr
//
//  Created by Blakeman, Mike on 10/29/21.
//

import Foundation
import RealmSwift

/// An enumeration of platforms to be assigned to work on.
enum Platform: Int, CaseIterable {
    case ios
    case android
    case cocoas2dx

    func toString() -> String {
        switch self {
        case .ios:
            return "iOS"
        case .android:
            return "Android"
        case .cocoas2dx:
            return "Cocoas2dX"
        }
    }
}
