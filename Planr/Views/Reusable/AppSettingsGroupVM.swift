//
//  AppSettingsGroupVM.swift
//  Planr
//
//  Created by Blakeman, Mike on 11/8/21.
//

import Foundation
import RealmSwift

class AppSettingsGroupVM: ObservableObject {
    @Published var velocity: Int
    @Published var sprintLength: Int
    @Published var estimatePadding: String

    private var settings: PlanrApplicationSettingsObject

    init() {
        do {
            let realm = try Realm()
            let results = realm.objects(PlanrApplicationSettingsObject.self)
            if let value = results.last {
                self.settings = value
            } else {
                self.settings = PlanrApplicationSettingsObject()
            }
        } catch let error {
            print(error.localizedDescription)
            self.settings = PlanrApplicationSettingsObject()
        }
        self.velocity = settings.teamVelocity
        self.sprintLength = settings.sprintLength
        self.estimatePadding = String(settings.estimatePaddingPercentage)
    }

    public func save() {
        do {
            let realm = try Realm()
            try realm.write {
                let newSettings = PlanrApplicationSettingsObject()
                newSettings.teamVelocity = self.velocity
                newSettings.sprintLength = self.sprintLength
                newSettings.estimatePaddingPercentage = Double(self.estimatePadding) ?? 0
                realm.add(newSettings)
            }
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
