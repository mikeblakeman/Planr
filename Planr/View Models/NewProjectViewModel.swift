//
//  NewProjectViewModel.swift
//  Planr
//
//  Created by Blakeman, Mike on 11/9/21.
//

import Foundation
import SwiftUI

/// View Model for the `NewProjectView`
///
/// This VM is used to hold data from the `NewProjectView` to bind the values to the UI.
class NewProjectViewModel: ObservableObject {
    @Published var projectName = "" {
        didSet {
            if projectName.count > 40 && oldValue.count <= 40 {
                projectName = oldValue
            }
        }
    }

    @Published var projectStartDate: Date = Date()
}
