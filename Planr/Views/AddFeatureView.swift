//
//  AddFeatureView.swift
//  Planr
//
//  Created by Blakeman, Mike on 11/10/21.
//

import SwiftUI
import NavigationStack

struct AddFeatureView: View {

    private var projectInProgress: Project

    init(withProjectInProgress project: Project) {
        self.projectInProgress = project
    }

    @EnvironmentObject private var navigationStack: NavigationStack

    @ObservedObject var addFeatureViewModel = AddFeatureViewModel()
    @ObservedObject var platformSelectionVM = PlatformSelectionViewModel()

    var body: some View {
        VStack(alignment: .center, spacing: nil, content: {
            LinearGradient(gradient: Gradient(colors: [Constants.firstGradientColor,
                                                       Constants.lastGradientColor]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
                .mask(Text("Add Feature").font(.system(size: 37, weight: .semibold)))
                .frame(maxHeight: 100)
            ScrollView {
                Form {
                    // Engineer first name view
                    VStack(alignment: .leading, spacing: 5, content: {
                        Text("Feature name:").font(.system(size: 22))
                        TextField("Feature name", text: $addFeatureViewModel.name)
                            .textFieldStyle(PlainTextFieldStyle())
                            .underlineTextField()
                    }).padding(25)

                    // Engineer last name view
                    VStack(alignment: .leading, spacing: 5, content: {
                        Text("Enter a summary of the feature (optional):").font(.system(size: 22))
                        TextField("Summary", text: $addFeatureViewModel.summary)
                            .textFieldStyle(PlainTextFieldStyle())
                            .underlineTextField()
                    }).padding(25)

                    // Engineer last name view
                    VStack(alignment: .leading, spacing: 5, content: {
                        Text("Enter the point estimate for the feature:").font(.system(size: 22))
                        TextField("12", text: $addFeatureViewModel.effortEstimate)
                            .textFieldStyle(PlainTextFieldStyle())
                            .underlineTextField()
                    }).padding(25)

                    // Engineer last name view
                    VStack(alignment: .leading, spacing: 5, content: {
                        Text("Enter the priority of the feature from 0 to 1000" +
                                "(higher number is higher priority):")
                            .font(.system(size: 22))
                        TextField("1000", text: $addFeatureViewModel.priority)
                            .textFieldStyle(PlainTextFieldStyle())
                            .underlineTextField()
                    }).padding(25)
                }

                // Engineer last name view
                HStack {
                    VStack(alignment: .leading, spacing: 5, content: {
                        Text("Can this feature be worked on concurrently:").font(.system(size: 22))
                        Toggle("Concurrent work allowed:", isOn: $addFeatureViewModel.concurrenyAllowed)
                        .font(.system(size: 24, weight: .semibold))
                        .toggleStyle(SwitchToggleStyle())
                        .padding(.trailing, 25)
                    }).padding(25)
                    Spacer()
                }

                // Platform selection view
                PlatformSelectionView(platformSelectionViewModel: platformSelectionVM,
                                      isActive: false,
                                      displayText: "Choose platforms for this feature:")
            }
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
                    if canProceed() {
                        self.addFeatureViewModel.platform = platformSelectionVM.platforms
                            .filter { $0.isActive }
                            .map { $0.platformType }
                        guard let feature = self.addFeatureViewModel.createFeature() else {
                            return
                        }

                        self.projectInProgress.addFeature(feature)
                        self.navigationStack.pop()
                    }
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
        return self.addFeatureViewModel.inputIsValid() && $platformSelectionVM.anySelected.wrappedValue
    }
}

struct AddFeaturesView_Previews: PreviewProvider {
    static var previews: some View {
        AddFeatureView(withProjectInProgress: getDemoProject())
            .frame(width: 1200, height: 1000, alignment: .center)
    }
}
