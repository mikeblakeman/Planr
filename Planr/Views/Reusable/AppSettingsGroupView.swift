//
//  AppSettingsGroupView.swift
//  Planr
//
//  Created by Blakeman, Mike on 11/8/21.
//

import SwiftUI
import RealmSwift

/// A reusable view for the app's settings.
struct AppSettingsGroupView: View {

    @AppStorage(Constants.averageVelocityKey) var velocity = 8
    @AppStorage(Constants.sprintLengthKey) var sprintLength = 2
    @AppStorage(Constants.estimatePaddingKey) var estimatePadding = 0.0

    var body: some View {
        VStack(alignment: .center, spacing: 50, content: {
            VStack(alignment: .leading, spacing: 5, content: {
                Text("Pick your team's average velocity:").font(.system(size: 22))
                Picker("", selection: $velocity) {
                    ForEach(2 ..< 21, id: \.self) { index in
                        Text(String(index))
                    }
                }.underlineTextField()
            }).padding(.horizontal, 25)

            VStack(alignment: .leading, spacing: 5, content: {
                Text("Pick your sprint lengths in weeks:").font(.system(size: 22))
                Picker("", selection: $sprintLength) {
                    ForEach(2 ..< 7, id: \.self) { index in
                        Text(String(index))
                    }
                }.underlineTextField()
                .pickerStyle(SegmentedPickerStyle())
            }).padding(.horizontal, 25)

            VStack(alignment: .leading, spacing: 5, content: {
                Text("Select the percent to pad given estimates: \(estimatePadding, specifier: "%.0f")%")
                    .font(.system(size: 22))
                Slider(value: $estimatePadding, in: 0...100, step: 1.0)
                    .underlineTextField()
            }).padding(.horizontal, 25)
        }).background(Color.white)
    }
}

struct AppSettingsGroupView_Previews: PreviewProvider {
    static var previews: some View {
        AppSettingsGroupView()
    }
}
