//
//  AddEngineersView.swift
//  Planr
//
//  Created by Blakeman, Mike on 11/10/21.
//

import SwiftUI

struct AddEngineersView: View {
    @ObservedObject var addEngineersViewModel = AddEngineersViewModel()
    @ObservedObject var platformSelectionViewModel = PlatformSelectionViewModel()
    @ObservedObject var multiDatePickerViewModel = MultiDatePickerViewModel()

    var body: some View {
        VStack(alignment: .center, spacing: nil, content: {
            LinearGradient(gradient: Gradient(colors: [Constants.firstGradientColor,
                                                       Constants.lastGradientColor]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
                .mask(
                    Text("Add Engineers")
                        .font(.system(size: 37, weight: .semibold))
                )
            Form {
                // Engineer first name view
                VStack(alignment: .leading, spacing: 5, content: {
                    Text("Engineer's first name:").font(.system(size: 22))
                    TextField("First name", text: $addEngineersViewModel.firstName)
                        .textFieldStyle(PlainTextFieldStyle())
                        .underlineTextField()
                }).padding(25)

                // Engineer last name view
                VStack(alignment: .leading, spacing: 5, content: {
                    Text("Engineer's last name:").font(.system(size: 22))
                    TextField("Last name", text: $addEngineersViewModel.lastName)
                        .textFieldStyle(PlainTextFieldStyle())
                        .underlineTextField()
                }).padding(25)

                // Platform selection view

            }
            PlatformSelectionView(platformSelectionViewModel: platformSelectionViewModel,
                                  isActive: false)

            MultiDatePickerView(multiDatePickerViewModel: multiDatePickerViewModel)
            Spacer()
            Button(action: {
                createEngineer()
            }, label: {
                HStack {
                    Text("Continue").font(.system(size: 18.0)).frame(width: 200)
                }
            }).buttonStyle(BooleanGradientButtonStyle())
            .padding(.vertical, 25)
            .disabled(addEngineersViewModel.firstName.isEmpty ||
                        addEngineersViewModel.lastName.isEmpty ||
                        !platformSelectionViewModel.anySelected)
        }).background(Color.white)
    }

    private func createEngineer() {
        let platforms = $platformSelectionViewModel.platforms
            .wrappedValue.filter { $0.isActive }
            .map { $0.platformType }
        let engineer = Engineer(firstName: $addEngineersViewModel.firstName.wrappedValue,
                                lastName: $addEngineersViewModel.lastName.wrappedValue,
                                platform: platforms,
                                unavailableDates: $multiDatePickerViewModel.selectedDates.wrappedValue)
        print(engineer)
    }
}

struct AddEngineersView_Previews: PreviewProvider {
    static var previews: some View {
        AddEngineersView().frame(width: 1200, height: 1000, alignment: .center)
    }
}
