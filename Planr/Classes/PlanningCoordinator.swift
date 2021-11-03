//
//  PlanningCoordinator.swift
//  Planr
//
//  Created by Blakeman, Mike on 10/27/21.
//

import Foundation

/// Use this struct to plan a `Roadmap`
struct PlanningCoordinator {

    private var project: Project
    private var sprintStartDate: Date
    private var averageVelocity: Int
    private var sprintLength: Int
    private var estimatePadding: Double
    private var sprintTimeInterval = TimeInterval()

    /// Initializer
    ///
    /// - Parameter project: `Project` of which to plan
    /// - Parameter sprintStartDate: First date to start the planning
    /// - Parameter averageVelocity: The average velocity of of each engineer
    /// - Parameter sprintLength: An `Int` count of weeks in a sprint
    /// - Parameter estimatePadding: A percent to pad given estimates to account for inaccuracy
    init(project: Project, sprintStartDate: Date, averageVelocity: Int, sprintLength: Int, estimatePadding: Double) {
        self.project = project
        self.sprintStartDate = sprintStartDate
        self.averageVelocity = averageVelocity
        self.sprintLength = sprintLength
        self.estimatePadding = estimatePadding
        self.sprintTimeInterval = (Double(sprintLength) * Constants.week) - (3 * Constants.day)
    }

    /// Function to plan an initialized `PlanningCoordinator`
    ///
    /// - Returns: A generated `Roadmap` with planned `Sprint`s
    func plan() -> Roadmap {
        // Arrange features by priority first
        let prioritizedFeatures = project.features.sorted {
            $0.priority > $1.priority
        }

        // Init planned features
        var plannedFeatureList = [PlannedFeature]()
        for feature in prioritizedFeatures {
            let plannedFeature = PlannedFeature(withUnplannedFeature: feature, averageVelocity: self.averageVelocity)
            plannedFeatureList.append(plannedFeature)
        }

        // TODO: Utilize estimate padding.

        // Get total capacity per sprint
        let totalCapacityPerSprint = averageVelocity * project.engineers.count

        // Get total number of sprint points to plan for
        var totalSprintPoints = 0
        for feature in plannedFeatureList {
            totalSprintPoints += (feature.effortEstimate * feature.platform.count)
        }

        // Get total number of sprints to plan for
        var totalSprintCount = totalSprintPoints / totalCapacityPerSprint
        if totalSprintPoints % totalCapacityPerSprint > 0 {
            totalSprintCount += 1
        }

        /* TODO: Get capacity per platform
        var platformCapacity: [String: Int] = [:]

        for feature in prioritizedFeatures {
            for platform in feature.platform where platformCapacity[platform.rawValue] == nil {
                    platformCapacity[platform.rawValue] = 0
            }
        }
        */

        // Init first sprint
        let initialSprintDateRange = DateInterval(start: sprintStartDate,
                                                  end: sprintStartDate.advanced(by: self.sprintTimeInterval))
        let initialSprint = Sprint(workBlocks: [],
                                   pointsRemaining: totalCapacityPerSprint,
                                   dateRange: initialSprintDateRange)

        // Setup sprint list
        var sprintList = [initialSprint]

        // Init sprints
        for index in 2...totalSprintCount {
            let startDate = sprintList[index - 2].dateRange.end + (3 * Constants.day)
            let endDate = startDate.advanced(by: self.sprintTimeInterval)
            let dateRange = DateInterval(start: startDate, end: endDate)

            let sprint = Sprint(workBlocks: [], pointsRemaining: totalCapacityPerSprint, dateRange: dateRange)
            sprintList.append(sprint)
        }

        // TODO: Don't calculate total sprints, keep creating sprints until plannedFeatureList is fully planned.

        // Plan resources
        for index in sprintList.indices {
            var sprint = sprintList[index]

            // TODO: Use engineer available dates
            var engineerAssignments: [Engineer: Int] = [:]
            for engineer in project.engineers {
                engineerAssignments[engineer] = averageVelocity
            }

            // Iterate through planned features and 
            for featureIndex in plannedFeatureList.indices {
                for platform in plannedFeatureList[featureIndex].platform {
                    if var unassignedWorkBlock =
                        plannedFeatureList[featureIndex].nextUnassignedWorkBlockForPlatform(platform: platform) {
                        try? unassignedWorkBlock.assignSprint(sprint.sprintId)
                        if sprint.pointsRemaining > unassignedWorkBlock.pointValue {
                            sprint.addWorkBlock(unassignedWorkBlock)
                            plannedFeatureList[featureIndex].assignWorkBlock(unassignedWorkBlock)
                        }
                    }
                }
            }

            sprintList[index] = sprint
        }

        return Roadmap(withSprints: sprintList)
    }
}
