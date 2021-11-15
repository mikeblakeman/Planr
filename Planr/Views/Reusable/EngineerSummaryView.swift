//
//  EngineerSummaryView.swift
//  Planr
//
//  Created by Blakeman, Mike on 11/10/21.
//

import SwiftUI

/// A reusable view to show the created `Engineer`.
///
/// This can be reused in a list to show created engineers.
struct EngineerSummaryView: View {
    @State private var engineer: Engineer

    init(withEngineer engineer: Engineer) {
        self.engineer = engineer
    }

    var body: some View {
        HStack(alignment: .top, spacing: nil, content: {
            getItemView(title: "Name: ",
                        body: "\(self.engineer.firstName) \(self.engineer.lastName)")
            getItemView(title: "Platforms: ", body: getPlatformList())
            getItemView(title: "Unavailable dates:", body: getDatesList())
            Spacer()
        })
    }

    private func getItemView(title: String, body: String) -> some View {
        return VStack(alignment: .leading, spacing: nil, content: {
            Text(title).font(.system(size: 22))
            Text(body)
        }).padding([.top, .trailing], 10).frame(width: 250, alignment: .topLeading)
    }

    private func getDatesList() -> String {
        var datesList = ""
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/YYYY"
        for date in self.engineer.unavailableDates {
            datesList.append(dateFormatter.string(from: date) + "\n")
        }
        return datesList == "" ? "None" : datesList
    }

    private func getPlatformList() -> String {
        var platformList = ""
        for platform in self.engineer.platform {
            platformList.append(platform.toString() + "\n")
        }
        return platformList
    }
}

struct EngineerSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        EngineerSummaryView(withEngineer: getDemoEngineerList().first!)
        EngineerSummaryView(withEngineer: getDemoEngineerList().last!)
    }
}
