//
//  ViewExtensions.swift
//  Planr
//
//  Created by Blakeman, Mike on 11/4/21.
//

import Foundation
import SwiftUI

// Extension to add a underline to 
extension View {
    func underlineTextField() -> some View {
        self.overlay(Rectangle().frame(height: 2).padding(.top, 35))
            .padding(.vertical, 10)
            .foregroundColor(Constants.firstGradientColor)
    }
}

// Extension to remove the focus ring on text fields.
extension NSTextField {
    open override var focusRingType: NSFocusRingType {
        get { .none }
        set {}
    }
}
