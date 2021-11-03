//
//  Roadmap.swift
//  Planr
//
//  Created by Blakeman, Mike on 10/27/21.
//

import Foundation

/// This represents a planned timeline of sprints
struct Roadmap {
    public private(set) var sprints: [Sprint]

    /// Initializer
    ///
    /// - Parameter sprints: A collection of planned `Sprint` objects.
    init(withSprints sprints: [Sprint]) {
        self.sprints = sprints
    }

    /// Logging helper function
    ///
    /// - Note: This is used to help visualize information about a planned `Roadmap`
    public func printRoadmap() {
        for index in self.sprints.indices {
            print("------------------------------------------------------------")
            print("| Sprint \(index + 1)")
            self.sprints[index].printSprintInfo()
        }
    }
}
