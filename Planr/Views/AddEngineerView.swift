//
//  AddEngineerView.swift
//  Planr
//
//  Created by Blakeman, Mike on 11/10/21.
//

import SwiftUI
import NavigationStack

/// The utility view to fill out all of the information on an `Engineer`
struct AddEngineerView: View {

    private var projectInProgress: Project

    /// Constructor
    ///
    /// - Parameter project: This passes in a `Project` object to add the created engineer to said project.
    init(withProjectInProgress project: Project) {
        self.projectInProgress = project
    }

    @EnvironmentObject private var navigationStack: NavigationStack

    @ObservedObject var addEngineerViewModel = AddEngineerViewModel()
    @ObservedObject var platformSelectionViewModel = PlatformSelectionViewModel()
    @ObservedObject var multiDatePickerViewModel = MultiDatePickerViewModel()

    var body: some View {
        VStack(alignment: .center, spacing: nil, content: {
            LinearGradient(gradient: Gradient(colors: [Constants.firstGradientColor,
                                                       Constants.lastGradientColor]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
                .mask(Text("Add Engineer").font(.system(size: 37, weight: .semibold)))
                .frame(maxHeight: 100)
            Form {
                // Engineer first name view
                VStack(alignment: .leading, spacing: 5, content: {
                    Text("Engineer's first name:").font(.system(size: 22))
                    TextField("First name", text: $addEngineerViewModel.firstName)
                        .textFieldStyle(PlainTextFieldStyle())
                        .underlineTextField()
                }).padding(25)

                // Engineer last name view
                VStack(alignment: .leading, spacing: 5, content: {
                    Text("Engineer's last name:").font(.system(size: 22))
                    TextField("Last name", text: $addEngineerViewModel.lastName)
                        .textFieldStyle(PlainTextFieldStyle())
                        .underlineTextField()
                }).padding(25)

                // Platform selection view

            }
            PlatformSelectionView(platformSelectionViewModel: platformSelectionViewModel,
                                  isActive: false,
                                  displayText: "Engineer's platform proficiencies:")

            MultiDatePickerView(multiDatePickerViewModel: multiDatePickerViewModel)
            Spacer()
            HStack(alignment: .center, spacing: 50, content: {
                Button(action: { self.navigationStack.pop() },
                       label: {
                        HStack { Text("Cancel")
                            .font(.system(size: 18.0))
                            .frame(width: 200)
                        }
                }).buttonStyle(BooleanGradientButtonStyle()).padding(.vertical, 25)

                Button(action: {
                    let platforms = $platformSelectionViewModel.platforms
                        .wrappedValue
                        .filter { $0.isActive }
                        .map { $0.platformType}
                    let dates = $multiDatePickerViewModel.selectedDates.wrappedValue
                    let engineer = self.addEngineerViewModel.createEngineer(platforms: platforms,
                                                                            unavailableDates: dates)

                    self.projectInProgress.addEngineer(engineer)

                    // Navigate to AddFeaturesView
                    self.navigationStack.pop()

                }, label: {
                    HStack {
                        Text("Save").font(.system(size: 18.0)).frame(width: 200)
                    }
                }).buttonStyle(BooleanGradientButtonStyle())
                .padding(.vertical, 25)
                .disabled(!canProceed())
            })
        }).background(Color.white)
    }

    private func canProceed() -> Bool {
        return !addEngineerViewModel.firstName.isEmpty &&
            !addEngineerViewModel.lastName.isEmpty &&
            platformSelectionViewModel.anySelected
    }
}

struct AddEngineerView_Previews: PreviewProvider {
    static var previews: some View {
        AddEngineerView(withProjectInProgress: getDemoProject())
            .frame(width: 1200, height: 1000, alignment: .center)
    }
}
