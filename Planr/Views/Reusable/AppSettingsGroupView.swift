//
//  AppSettingsGroupView.swift
//  Planr
//
//  Created by Blakeman, Mike on 11/8/21.
//

import SwiftUI
import RealmSwift

struct AppSettingsGroupView: View {

    @ObservedObject var viewModel = AppSettingsGroupVM()

    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 5, content: {
                Text("Pick your team's average velocity:").font(.system(size: 22))
                Picker("", selection: $viewModel.velocity) {
                    ForEach(2 ..< 21, id: \.self) { index in
                        Text(String(index))
                    }
                }.underlineTextField()
            }).padding(.horizontal, 25)

            Spacer()

            VStack(alignment: .leading, spacing: 5, content: {
                Text("Pick your sprint lengths in weeks:").font(.system(size: 22))
                Picker("", selection: $viewModel.sprintLength) {
                    ForEach(2 ..< 7, id: \.self) { index in
                        Text(String(index))
                    }
                }.underlineTextField()
                .pickerStyle(SegmentedPickerStyle())
            }).padding(.horizontal, 25)

            Spacer()

            VStack(alignment: .leading, spacing: 5, content: {
                Text("Enter the percent to pad given estimates:").font(.system(size: 22))
                TextField("0", text: $viewModel.estimatePadding)
                    .textFieldStyle(PlainTextFieldStyle())
                    .underlineTextField()
            }).padding(.horizontal, 25)
        }.background(Color.white)
    }

    public func save() {
        self.viewModel.save()
    }
}

struct AppSettingsGroupView_Previews: PreviewProvider {
    static var previews: some View {
        AppSettingsGroupView()
    }
}
