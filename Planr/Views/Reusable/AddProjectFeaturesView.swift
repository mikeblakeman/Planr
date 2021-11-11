//
//  AddProjectFeaturesView.swift
//  Planr
//
//  Created by Blakeman, Mike on 11/11/21.
//

import SwiftUI
import NavigationStack

struct AddProjectFeaturesView: View {

    @State private var projectInProgress: Project

    @EnvironmentObject private var navigationStack: NavigationStack

    init(withProject project: Project) {
        self.projectInProgress = project
    }

    var body: some View {
        VStack(alignment: .center, spacing: nil, content: {
            LinearGradient(gradient: Gradient(colors: [Constants.firstGradientColor,
                                                       Constants.lastGradientColor]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
                .mask(Text("Add Project Features").font(.system(size: 37, weight: .semibold)))
                .frame(maxHeight: 100)
            VStack(alignment: .leading, spacing: nil, content: {

                getAddButtonView()
                Text("Features:").font(.system(size: 27))
                    .padding([.horizontal, .bottom], 25)
                List(self.projectInProgress.features,
                     id: \.self) { feature in
                    FeatureSummaryView(withFeature: feature)
                }.padding(10)
            })
            Spacer()
            Button(action: {
                let roadmap = PlanningCoordinator(project: self.projectInProgress).plan()
                self.navigationStack.push(
                    ProjectRoadmapView(projectName: self.projectInProgress.name,
                                       roadmap: roadmap)
                )
            }, label: {
                HStack {
                    Text("View Roadmap").font(.system(size: 18.0)).frame(width: 200)
                }
            }).buttonStyle(BooleanGradientButtonStyle())
            .padding(.vertical, 25)
            .disabled(!canProceed())
        }).background(Color.white)
    }

    private func getAddButtonView() -> some View {
        return Button(action: {
            self.navigationStack.push(AddFeatureView(withProjectInProgress: self.projectInProgress))
        }, label: {
            HStack {
                Image(systemName: "pencil.circle.fill")
                    .font(.system(size: 22.0))
                Text("Add Feature")
                    .font(.system(size: 18.0))
            }
        }).buttonStyle(GradientButtonStyle()).padding()
    }

    private func canProceed() -> Bool {
        return !self.projectInProgress.features.isEmpty
    }
}

struct AddProjectFeaturesView_Previews: PreviewProvider {
    static var previews: some View {
        AddProjectFeaturesView(withProject: getDemoProject())
            .frame(width: 1200, height: 1000, alignment: .center)
    }
}
