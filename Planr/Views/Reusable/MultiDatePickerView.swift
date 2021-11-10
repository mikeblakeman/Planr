//
//  MultiDatePickerView.swift
//  Planr
//
//  Created by Blakeman, Mike on 11/10/21.
//
//  Multi-Date-Picker from https://www.keaura.com/blog/a-multi-date-picker-for-swiftui

import SwiftUI

struct MultiDatePickerView: View {

    @ObservedObject var multiDatePickerViewModel = MultiDatePickerViewModel()

    var body: some View {
        HStack {
            VStack {
                Text("Engineer's unavailable dates:").font(.system(size: 22))
                MultiDatePicker(anyDays: self.$multiDatePickerViewModel.selectedDates, includeDays: .weekdaysOnly)
            }.padding(10)
            Spacer()
        }
    }
}

struct MultiDatePickerView_Previews: PreviewProvider {
    static var previews: some View {
        MultiDatePickerView().frame(width: 1200, height: 1000, alignment: .center)
    }
}
