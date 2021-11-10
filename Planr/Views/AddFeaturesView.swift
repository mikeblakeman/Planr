//
//  AddFeaturesView.swift
//  Planr
//
//  Created by Blakeman, Mike on 11/10/21.
//

import SwiftUI

struct AddFeaturesView: View {
    @ObservedObject var addFeaturesViewModel = AddFeaturesViewModel()

    var body: some View {
        VStack(alignment: .center, spacing: 50, content: {
            LinearGradient(gradient: Gradient(colors: [Constants.firstGradientColor,
                                                       Constants.lastGradientColor]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
                .mask(
                    Text("Add Features")
                        .font(.system(size: 37, weight: .semibold))
                )

            Spacer()
            VStack(alignment: .leading, spacing: 50, content: {


            }).padding(.horizontal, 25)
            Spacer()
            Button(action: {
//                createNewProject()
            }, label: {
                HStack {
                    Text("Continue").font(.system(size: 18.0)).frame(width: 200)
                }
            }).buttonStyle(BooleanGradientButtonStyle())
            .padding(.vertical, 25)
//            .disabled()
        }).background(Color.white)
    }
}

struct AddFeaturesView_Previews: PreviewProvider {
    static var previews: some View {
        AddFeaturesView().frame(width: 1200, height: 1000, alignment: .center)
    }
}
