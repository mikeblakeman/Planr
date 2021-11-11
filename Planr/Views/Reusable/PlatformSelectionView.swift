//
//  PlatformSelectionView.swift
//  Planr
//
//  Created by Blakeman, Mike on 11/10/21.
//

import SwiftUI

struct PlatformSelectionView: View {
    @ObservedObject var platformSelectionViewModel = PlatformSelectionViewModel()
    @State var isActive: Bool = false
    @State var displayText = ""

    var body: some View {
        // Engineer platform view
        VStack(alignment: .leading, spacing: 5, content: {
            Text($displayText.wrappedValue).font(.system(size: 22))
            HStack {
                ForEach(self.platformSelectionViewModel.platforms, id: \.self) { platform in
                    Toggle(platform.platformType.toString(), isOn: Binding<Bool>(
                        get: { platform.isActive },
                        set: {
                            if let index =
                                platformSelectionViewModel.platforms.firstIndex(where: {
                                                                                    $0.modelId == platform.modelId }) {
                                    platformSelectionViewModel.platforms[index] =
                                        PlatformSelectionModel(modelId: platform.modelId,
                                                               platformType: platform.platformType,
                                                               isActive: $0)
                                }
                            }
                    )).font(.system(size: 37, weight: .semibold))
                    .toggleStyle(SwitchToggleStyle())
                    .padding(.trailing, 25)
                }
                Spacer()
            }
            Divider().overlay(Rectangle().frame(height: 2).foregroundColor(Constants.firstGradientColor))
        }).padding(25)
    }
}

struct PlatformSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        PlatformSelectionView().frame(width: 700, height: 200, alignment: .center)
    }
}
