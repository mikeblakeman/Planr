//
//  Util.swift
//  Planr
//
//  Created by Blakeman, Mike on 11/4/21.
//

import Foundation
import SwiftUI

struct GradientButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.white)
            .padding()
            .background(configuration.isPressed ? Constants.selectedButtonGradient : Constants.unselectedButtonGradient)
            .cornerRadius(15.0)
    }
}
