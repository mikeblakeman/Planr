//
//  Project.swift
//  Planr
//
//  Created by Blakeman, Mike on 8/25/21.
//

import Foundation

struct Project {
    public private(set) var name: String
    public private(set) var features: [UnplannedFeature]
    public private(set) var engineers: [Engineer]

    init(name: String, _ features: [UnplannedFeature] = [], _ engineers: [Engineer] = []) {
        self.name = name
        self.features = features
        self.engineers = engineers
    }

    public mutating func addFeature(_ feature: UnplannedFeature) {
        features.append(feature)
    }

    public mutating func addFeatures(_ features: [UnplannedFeature]) {
        for feature in features {
            self.features.append(feature)
        }
    }

    public mutating func addEngineer(_ engineer: Engineer) {
        engineers.append(engineer)
    }

    public mutating func addEngineers(_ engineers: [Engineer]) {
        for engineer in engineers {
            self.engineers.append(engineer)
        }
    }
}
