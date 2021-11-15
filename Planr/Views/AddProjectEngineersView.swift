//
//  AddProjectEngineersView.swift
//  Planr
//
//  Created by Blakeman, Mike on 11/10/21.
//

import SwiftUI
import NavigationStack

/// The container view to add and view project engineers.
struct AddProjectEngineersView: View {

    @State private var projectInProgress: Project

    @EnvironmentObject private var navigationStack: NavigationStack

    /// Constructor
    ///
    /// - Parameter project: This passes in a `Project` object to add the created engineers to said project.
    init(withProject project: Project) {
        self.projectInProgress = project
    }

    var body: some View {
        VStack(alignment: .center, spacing: nil, content: {
            LinearGradient(gradient: Gradient(colors: [Constants.firstGradientColor,
                                                       Constants.lastGradientColor]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
                .mask(Text("Add Project Engineers").font(.system(size: 37, weight: .semibold)))
                .frame(maxHeight: 100)
            VStack(alignment: .leading, spacing: nil, content: {

                getAddButtonView()
                Text("Engineers:").font(.system(size: 27))
                    .padding([.horizontal, .bottom], 25)
                List(self.projectInProgress.engineers,
                     id: \.self) { engineer in
                    EngineerSummaryView(withEngineer: engineer)
                }.padding(10)
            })
            Spacer()
            Button(action: {
                self.navigationStack.push(AddProjectFeaturesView(withProject: self.projectInProgress))
            }, label: {
                HStack {
                    Text("Continue").font(.system(size: 18.0)).frame(width: 200)
                }
            }).buttonStyle(BooleanGradientButtonStyle())
            .padding(.vertical, 25)
            .disabled(!canProceed())
        }).background(Color.white)
    }

    private func getAddButtonView() -> some View {
        return Button(action: {
            self.navigationStack.push(AddEngineerView(withProjectInProgress: self.projectInProgress))
        }, label: {
            HStack {
                Image(systemName: "pencil.circle.fill")
                    .font(.system(size: 22.0))
                Text("Add Engineer")
                    .font(.system(size: 18.0))
            }
        }).buttonStyle(GradientButtonStyle()).padding()
    }

    private func canProceed() -> Bool {
        return !self.projectInProgress.engineers.isEmpty
    }
}

struct AddProjectEngineersView_Previews: PreviewProvider {
    static var previews: some View {
        AddProjectEngineersView(withProject: getDemoProject())
            .frame(width: 1200, height: 1000, alignment: .center)
    }
}
