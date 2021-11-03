//
//  Roadmap.swift
//  Planr
//
//  Created by Blakeman, Mike on 10/27/21.
//

import Foundation

struct Roadmap {
    public private(set) var sprints: [Sprint]

    init(withSprints sprints: [Sprint]) {
        self.sprints = sprints
    }

    public func printRoadmap() {
        for sprint in self.sprints {
            sprint.printSprintInfo()
        }
    }
}
