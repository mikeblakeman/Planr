//
//  ReusableButton.swift
//  Planr
//
//  Created by Blakeman, Mike on 11/5/21.
//

import SwiftUI

/// A reusable `ButtonStyle` to be used for buttons that should have the same gradient applied.
///
/// Use this button style for styled gradient buttons with a disabled state.
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

/// A reusable `ButtonStyle` to be used for buttons that should have the same gradient applied.
///
/// Use this button style for styled gradient buttons that do not have a disabled state.
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
