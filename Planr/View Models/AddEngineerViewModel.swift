//
//  AddEngineerViewModel.swift
//  Planr
//
//  Created by Blakeman, Mike on 11/10/21.
//

import Foundation
import RealmSwift

class AddEngineerViewModel: ObservableObject {
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

    @Published var engineerList: RealmSwift.List<RealmEngineer> = RealmSwift.List<RealmEngineer>()

    func createEngineer(platforms: [Platform], unavailableDates: [Date]) -> Engineer {
        let realmEngineer = RealmEngineer()
        realmEngineer.firstName = self.firstName
        realmEngineer.lastName = self.lastName
        realmEngineer.platform = RealmSwift.List<Int>()
        realmEngineer.platform.append(objectsIn: platforms.map { $0.rawValue })
        realmEngineer.unavailableDates = RealmSwift.List<Date>()
        realmEngineer.unavailableDates.append(objectsIn: unavailableDates)

        self.engineerList.append(realmEngineer)

        do {
            let realm = try Realm()

            try realm.write {
                realm.add(realmEngineer)
            }
        } catch let error {
            print(error.localizedDescription)
        }

        return Engineer(withRealmEngineer: realmEngineer)
    }
}
