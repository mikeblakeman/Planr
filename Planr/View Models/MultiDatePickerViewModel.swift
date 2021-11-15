//
//  MultiDatePickerViewModel.swift
//  Planr
//
//  Created by Blakeman, Mike on 11/10/21.
//

import Foundation

/// View Model for the `MultiDatePickerView`
///
/// This VM is used to hold data from the `MultiDatePickerView` to bind the values to the UI.
class MultiDatePickerViewModel: ObservableObject {
    @Published var selectedDates: [Date] = []
}
