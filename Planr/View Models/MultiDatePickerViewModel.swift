//
//  MultiDatePickerViewModel.swift
//  Planr
//
//  Created by Blakeman, Mike on 11/10/21.
//

import Foundation

class MultiDatePickerViewModel: ObservableObject {
    @Published var selectedDates: [Date] = []
}
