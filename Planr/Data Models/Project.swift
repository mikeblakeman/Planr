//
//  Project.swift
//  Planr
//
//  Created by Blakeman, Mike on 8/25/21.
//

import Foundation

/// A representation of an unplanned body of work containing engineers and unplanned features.
struct Project {
    public private(set) var name: String
    public private(set) var features: [UnplannedFeature]
    public private(set) var engineers: [Engineer]

    /// Initializer
    ///
    /// - Parameter name: The name of the project.
    /// - Parameter features: A collection of `UnplannedFeature`s to plan.
    /// - Parameter engineers: A collection of `Engineer` to assign work to.
    init(name: String, _ features: [UnplannedFeature] = [], _ engineers: [Engineer] = []) {
        self.name = name
        self.features = features
        self.engineers = engineers
    }

    /// A method to add a single `UnplannedFeature` to the `Project`
    ///
    /// - Parameter feature: The `UnplannedFeature` to add to the project.
    public mutating func addFeature(_ feature: UnplannedFeature) {
        addFeatures([feature])
    }

    /// A method to add a collection of `UnplannedFeature` to the `Project`
    ///
    /// - Parameter features: The `UnplannedFeature`s to add to the project.
    public mutating func addFeatures(_ features: [UnplannedFeature]) {
        for feature in features {
            self.features.append(feature)
        }
    }

    /// A method to add a single `Engineer` to the `Project`
    ///
    /// - Parameter engineer: The `Engineer` to add to the project.
    public mutating func addEngineer(_ engineer: Engineer) {
        addEngineers([engineer])
    }

    /// A method to add a  collection of `Engineer` to the `Project`
    ///
    /// - Parameter engineers: The `Engineer`s to add to the project.
    public mutating func addEngineers(_ engineers: [Engineer]) {
        for engineer in engineers {
            self.engineers.append(engineer)
        }
    }
}
