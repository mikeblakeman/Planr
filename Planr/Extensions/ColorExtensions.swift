//
//  ColorExtensions.swift
//  Planr
//
//  Created by Blakeman, Mike on 11/7/21.
//

import Foundation
import SwiftUI

extension Color {
    func colorWithHexString(hexString: String, alpha: Double = 1.0) -> Color {

        // Convert hex string to an integer
        let hexint = Int(self.intFromHexString(hexStr: hexString))
        let red = Double((hexint & 0xff0000) >> 16) / 255.0
        let green = Double((hexint & 0xff00) >> 8) / 255.0
        let blue = Double((hexint & 0xff) >> 0) / 255.0

        // Create color object, specifying alpha as well
        let color = Color(red: red, green: green, blue: blue, opacity: alpha)

        return color
    }

    func intFromHexString(hexStr: String) -> UInt32 {
        var hexInt: UInt32 = 0

        // Create scanner
        let scanner: Scanner = Scanner(string: hexStr)

        // Tell scanner to skip the # character
        scanner.charactersToBeSkipped = CharacterSet(charactersIn: "#")

        // Scan hex value
        scanner.scanHexInt32(&hexInt)
        return hexInt
    }
}
