//
//  NewProjectView.swift
//  Planr
//
//  Created by Blakeman, Mike on 11/5/21.
//

import SwiftUI

class TextBindingManager: ObservableObject {
    @Published var projectNameText = "" {
        didSet {
            if projectNameText.count > 40 && oldValue.count <= 40 {
                projectNameText = oldValue
            }
        }
    }
}

struct NewProjectView: View {
    @ObservedObject var textBindingManager = TextBindingManager()

    var body: some View {
        VStack(alignment: .center, spacing: 40, content: {
            Text("New Project")
                .gradientForeground(colors: [Constants.firstGradientColor,
                                             Constants.lastGradientColor])
                .padding(.horizontal, 10)
                .padding(.vertical, 25)
                .font(.system(size: 37, weight: .semibold))

            VStack(alignment: .leading, spacing: 5, content: {
                Text("Enter the name of your project:")
                    .font(.system(size: 22))
                HStack {
                    TextField("Project Name", text: $textBindingManager.projectNameText)
                        .textFieldStyle(PlainTextFieldStyle())
                }.underlineTextField()
            })
            .padding(.horizontal, 25)
            Spacer()
            Button(action: {
                print("Button action")
            }, label: {
                HStack {
                    Text("Continue")
                        .font(.system(size: 18.0))
                        .frame(width: 200)
                }
            }).buttonStyle(GradientButtonStyle())
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
}

struct NewProjectView_Previews: PreviewProvider {
    static var previews: some View {
        NewProjectView()
    }
}
