//
//  ReusableButton.swift
//  Planr
//
//  Created by Blakeman, Mike on 11/5/21.
//

import SwiftUI

struct BooleanGradientButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        GradientButton(configuration: configuration)
    }

    struct GradientButton: View {
        let configuration: ButtonStyle.Configuration
        @Environment(\.isEnabled) private var isEnabled: Bool
        var body: some View {
            configuration.label
                .foregroundColor(.white)
                .padding()
                .background(!isEnabled
                                ? Constants.disabledButtonGradient
                                : (configuration.isPressed
                                    ? Constants.selectedButtonGradient
                                    : Constants.unselectedButtonGradient))
                .cornerRadius(15.0)
        }
    }
}

struct GradientButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        GradientButton(configuration: configuration)
    }

    struct GradientButton: View {
        let configuration: ButtonStyle.Configuration
        var body: some View {
            configuration.label
                .foregroundColor(.white)
                .padding()
                .background(configuration.isPressed
                                ? Constants.selectedButtonGradient
                                : Constants.unselectedButtonGradient)
                .cornerRadius(15.0)
        }
    }
}
