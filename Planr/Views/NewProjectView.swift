//
//  NewProjectView.swift
//  Planr
//
//  Created by Blakeman, Mike on 11/5/21.
//

import SwiftUI
import RealmSwift

class TextBindingManager: ObservableObject {
    @Published var projectNameText = "" {
        didSet {
            if projectNameText.count > 40 && oldValue.count <= 40 {
                projectNameText = oldValue
            }
        }
    }

    @Published var projectEstimatePadding = "" {
        didSet {
            let filtered = projectEstimatePadding.filter { $0.isWholeNumber }

            if projectEstimatePadding != filtered {
                projectEstimatePadding = filtered
            }

            let toInt = Int(projectEstimatePadding) ?? -1

            if toInt == -1 {
                projectEstimatePadding = "0"
            }

            if toInt > 100 {
                projectEstimatePadding = "100"
            }
        }
    }
}

struct NewProjectView: View {
    @ObservedObject var textBindingManager = TextBindingManager()
    @State var projectNameFieldValue = ""
    @State var projectEstimatePaddingValue = 0.0

    var body: some View {
        VStack(alignment: .center, spacing: 40, content: {
            LinearGradient(gradient: Gradient(colors: [Constants.firstGradientColor,
                                                       Constants.lastGradientColor]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
                .mask(
                    Text("New Project")
                        .padding(.horizontal, 10)
                        .padding(.vertical, 50)
                        .font(.system(size: 37, weight: .semibold))
                )

            VStack(alignment: .leading, spacing: 5, content: {
                ProjectNameView(textBindingManager: textBindingManager)

                Spacer()

                ProjectDateView()

                Spacer()

                ProjectVelocityView()

                Spacer()

                SprintLengthView()

                Spacer()

                EstimatePaddingView()
            }).padding(.horizontal, 25)
            Spacer()
            Button(action: {
                saveNewProjectToRealm()
            }, label: {
                HStack {
                    Text("Continue")
                        .font(.system(size: 18.0))
                        .frame(width: 200)
                }
            }).buttonStyle(BooleanGradientButtonStyle())
            .padding(.vertical, 25)
            .disabled(textBindingManager.projectNameText.isEmpty)
        })
        .frame(minWidth: 1000,
               idealWidth: 1200,
               maxWidth: .infinity,
               minHeight: 800,
               idealHeight: 1000,
               maxHeight: .infinity,
               alignment: .top)
        .background(Color(white: 1)).edgesIgnoringSafeArea(.all)
    }

    func saveNewProjectToRealm() {
        // TODO: Save project details to RealmDB
    }
}

struct NewProjectView_Previews: PreviewProvider {
    static var previews: some View {
        NewProjectView()
    }
}

struct ProjectNameView: View {
    @ObservedObject var textBindingManager = TextBindingManager()

    var body: some View {
        VStack(alignment: .leading, spacing: 5, content: {
            Text("Enter the name of your project:").font(.system(size: 22))
            TextField("Project Name", text: $textBindingManager.projectNameText)
                .textFieldStyle(PlainTextFieldStyle())
                .underlineTextField()
        }).padding(.horizontal, 25)
    }
}

struct ProjectDateView: View {
    @State var sprintStartDate = Date()

    var body: some View {
        VStack(alignment: .leading, spacing: 5, content: {
            Text("Pick a project start date: ").font(.system(size: 22))
            DatePicker(
                "",
                selection: $sprintStartDate,
                displayedComponents: [.date]
            ).underlineTextField()
        }).padding(.horizontal, 25)
    }
}

struct ProjectVelocityView: View {
    @State private var averageVelocity = 8

    var body: some View {
        VStack(alignment: .leading, spacing: 5, content: {
            Text("Pick your team's average velocity:").font(.system(size: 22))
            Picker("", selection: $averageVelocity) {
                ForEach(2 ..< 21) { Text("\($0)") }
            }.underlineTextField()
            .onAppear {
                averageVelocity = 8
            }
        }).padding(.horizontal, 25)
    }
}

struct SprintLengthView: View {
    @State private var sprintLength = 2

    var body: some View {
        VStack(alignment: .leading, spacing: 5, content: {
            Text("Pick your sprint lengths in weeks:").font(.system(size: 22))
            Picker("", selection: $sprintLength) {
                ForEach(2 ..< 7) {
                    Text("\($0)")
                }
            }.underlineTextField()
            .pickerStyle(SegmentedPickerStyle())
        }).padding(.horizontal, 25)
    }
}

struct EstimatePaddingView: View {
    @ObservedObject var textBindingManager = TextBindingManager()

    var body: some View {
        VStack(alignment: .leading, spacing: 5, content: {
            Text("Enter the percent to pad given estimates:").font(.system(size: 22))
            TextField("0", text: $textBindingManager.projectEstimatePadding)
                .textFieldStyle(PlainTextFieldStyle())
                .underlineTextField()
        }).padding(.horizontal, 25)
    }
}
