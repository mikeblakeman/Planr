//
//  FeatureSummaryView.swift
//  Planr
//
//  Created by Blakeman, Mike on 11/10/21.
//

import SwiftUI

struct FeatureSummaryView: View {

    @State private var feature: UnplannedFeature

    init(withFeature feature: UnplannedFeature) {
        self.feature = feature
    }

    var body: some View {
        HStack(alignment: .top, spacing: 25, content: {
            HStack(alignment: .center, spacing: nil, content: {
                Circle()
                    .frame(width: 30, height: 30)
                    .foregroundColor(self.feature.color)
                    .padding()
                VStack(alignment: .leading, spacing: nil, content: {
                    Text(self.feature.name).font(.system(size: 30))
                    if let summary = self.feature.summary {
                        Text(summary).font(.system(size: 18))
                    }
                })
            })
            Spacer()
            getItemView(title: "Points: ", body: "\(self.feature.effortEstimate)")
            getItemView(title: "Priority: ", body: "\(self.feature.priority)")
            getItemView(title: "Platforms: ", body: getPlatformList())
        }).padding()
    }

    private func getItemView(title: String, body: String) -> some View {
        return VStack(alignment: .leading, spacing: nil, content: {
            Text(title).font(.system(size: 22))
            Text(body)
        }).padding(.trailing, 25)
    }

    private func getPlatformList() -> String {
        var platformList = ""
        for platform in self.feature.platform {
            platformList.append(platform.toString() + "\n")
        }
        return platformList
    }
}

struct FeatureSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        FeatureSummaryView(withFeature: getDemoUnplannedFeatureList().first!)
            .frame(width: 1000)
        FeatureSummaryView(withFeature: getDemoUnplannedFeatureList().last!)
            .frame(width: 1000)
    }
}
