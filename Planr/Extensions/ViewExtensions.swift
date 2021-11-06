//
//  ViewExtensions.swift
//  Planr
//
//  Created by Blakeman, Mike on 11/4/21.
//

import Foundation
import SwiftUI

extension View {
    public func gradientForeground(colors: [Color]) -> some View {
        self.overlay(LinearGradient(gradient: .init(colors: colors),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing))
            .mask(self)
    }
}

extension View {
    func underlineTextField() -> some View {
        self.overlay(Rectangle().frame(height: 2).padding(.top, 35))
            .padding(.vertical, 10)
            .foregroundColor(Constants.firstGradientColor)
    }
}

extension NSTextField {
    open override var focusRingType: NSFocusRingType {
        get { .none }
        set {}
    }
}