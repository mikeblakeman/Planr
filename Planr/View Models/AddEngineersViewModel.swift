//
//  AddEngineersViewModel.swift
//  Planr
//
//  Created by Blakeman, Mike on 11/10/21.
//

import Foundation
import RealmSwift

class AddEngineersViewModel: ObservableObject {
    @Published var firstName = "" {
        didSet {
            if firstName.count > Constants.engineerNameMaxLength && oldValue.count <= Constants.engineerNameMaxLength {
                firstName = oldValue
            }

            if firstName.rangeOfCharacter(from: CharacterSet.letters.inverted) != nil {
                firstName = oldValue
            }
        }
    }

    @Published var lastName = "" {
        didSet {
            if lastName.count > Constants.engineerNameMaxLength && oldValue.count <= Constants.engineerNameMaxLength {
                lastName = oldValue
            }

            if lastName.rangeOfCharacter(from: CharacterSet.letters.inverted) != nil {
                lastName = oldValue
            }
        }
    }

    @Published var unavailableDates: [Date] = []
}
