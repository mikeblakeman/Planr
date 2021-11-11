//
//  NewProjectView.swift
//  Planr
//
//  Created by Blakeman, Mike on 11/5/21.
//

import SwiftUI
import RealmSwift
import NavigationStack

struct NewProjectView: View {

    @EnvironmentObject private var navigationStack: NavigationStack

    @ObservedObject var newProjectViewModel = NewProjectViewModel()

    @State var realm: Realm?

    var body: some View {
        VStack(alignment: .center, spacing: nil, content: {
            LinearGradient(gradient: Gradient(colors: [Constants.firstGradientColor,
                                                       Constants.lastGradientColor]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
                .mask(Text("New Project").font(.system(size: 37, weight: .semibold)))
                .frame(maxHeight: 100)
            VStack(alignment: .leading, spacing: 50, content: {

                // Project name view
                VStack(alignment: .leading, spacing: 5, content: {
                    Text("Enter the name of your project:").font(.system(size: 22))
                    TextField("Project Name", text: $newProjectViewModel.projectName)
                        .textFieldStyle(PlainTextFieldStyle())
                        .underlineTextField()
                }).padding(.horizontal, 25)

                // Project start date view
                VStack(alignment: .leading, spacing: 5, content: {
                    Text("Pick a project start date: ").font(.system(size: 22))
                    DatePicker(
                        "",
                        selection: $newProjectViewModel.projectStartDate,
                        displayedComponents: [.date]
                    ).underlineTextField()
                }).padding(.horizontal, 25)

                // App settings shared view
                AppSettingsGroupView()
            })
            Spacer()
            Button(action: {
                createNewProject()
            }, label: {
                HStack {
                    Text("Continue").font(.system(size: 18.0)).frame(width: 200)
                }
            }).buttonStyle(BooleanGradientButtonStyle())
            .padding(.vertical, 25)
            .disabled(newProjectViewModel.projectName.isEmpty)
        }).background(Color.white)
    }

    private func createNewProject() {
        let project = Project(name: $newProjectViewModel.projectName.wrappedValue,
                              startDate: $newProjectViewModel.projectStartDate.wrappedValue)
        self.navigationStack.push(AddProjectEngineersView(withProject: project))
    }
}

struct NewProjectView_Previews: PreviewProvider {
    static var previews: some View {
        NewProjectView().frame(width: 1200, height: 1000, alignment: .center)
    }
}
