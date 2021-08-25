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

struct Engineer {
    private var name: String
    private var platform: [Platform]
    private var unavailableDates: [Date]

    init(name: String, platform: [Platform], unavailableDates: [Date]) {
        self.name = name
        self.platform = platform
        self.unavailableDates = unavailableDates
    }
}
