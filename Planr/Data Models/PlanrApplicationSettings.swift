//
//  PlanrApplicationSettings.swift
//  Planr
//
//  Created by Blakeman, Mike on 11/8/21.
//

import SwiftUI
import RealmSwift

class PlanrApplicationSettingsObject: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var teamVelocity: Int = 0
    @Persisted var sprintLength: Int = 0
    @Persisted var estimatePaddingPercentage: Double = 0.0
}
