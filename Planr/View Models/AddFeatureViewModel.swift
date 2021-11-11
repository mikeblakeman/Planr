//
//  AddFeatureViewModel.swift
//  Planr
//
//  Created by Blakeman, Mike on 11/10/21.
//

import Foundation

class AddFeatureViewModel: ObservableObject {

    @Published var name = "" {
        didSet {
            if name.count > Constants.featureNameMaxLength && oldValue.count <= Constants.featureNameMaxLength {
                name = oldValue
            }
        }
    }

    @Published var summary = "" {
        didSet {
            if summary.count > Constants.summaryMaxCharacterLength &&
                oldValue.count <= Constants.summaryMaxCharacterLength {
                summary = oldValue
            }
        }
    }

    @Published var platform: [Platform] = []
    
    @Published var effortEstimate = "0" {
        didSet {
            if effortEstimate.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) != nil {
                effortEstimate = oldValue
            }

            if effortEstimate.count > 3 {
                effortEstimate = oldValue
            }

            if let integer = Int(effortEstimate), integer > 100 {
                effortEstimate = oldValue
            }
        }
    }

    @Published var priority = "0" {
        didSet {
            if priority.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) != nil {
                priority = oldValue
            }

            if priority.count > 4 {
                priority = oldValue
            }

            if let integer = Int(effortEstimate), integer > 1000 {
                priority = oldValue
            }
        }
    }

    @Published var concurrenyAllowed = false

    func inputIsValid() -> Bool {
        if self.name.isEmpty { return false }

        if let effortInt = Int(effortEstimate) {
            if effortInt == 0 { return false }
        }

        return true
    }

    func createFeature() -> UnplannedFeature? {
        if let effort = Int(self.effortEstimate), let localPriority = Int(self.priority) {
            return UnplannedFeature(name: self.name,
                                    self.summary,
                                    platform: self.platform,
                                    effortEstimate: effort,
                                    priority: localPriority)
        }

        return nil
    }
}
