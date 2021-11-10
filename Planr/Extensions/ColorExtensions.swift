//
//  ColorExtensions.swift
//  Planr
//
//  Created by Blakeman, Mike on 11/7/21.
//

import Foundation
import SwiftUI
import AppKit

/// Color extension to add convenience methods to get a `Color` object from a hex string
public extension Color {
    /// Initializes and returns a color object from a Hexadecimal RGB / ARGB color `String`.
    ///
    /// This can be constructed with RGB or ARGB formatted Hexadecimal strings, including the
    /// leading "#" character. For example '#AA65CA' or '#99AA65CA' are both valid inputs.
    ///
    /// - Parameters:
    ///   - hexString: The hexidecimal `String` to be converted to `UIColor`
    /// - Important: The hexString parameter must be 8 or 6 characters in length not
    ///   including the leading "#" character. The hexString parameter must also contain only
    ///   valid Hexadecimal values.
    /// - Returns: The color object. If input is invalid this will return a bright green color (#32FF32)
    init?(hexString: String) {
        // Remove leading '#'
        let formattedHex = hexString.replacingOccurrences(of: "#", with: "")

        // Must be in RGB or ARGB format
        let size = formattedHex.count
        guard size == 6 || size == 8 else {
            print("Invalid RGB / ARGB format. Must be 8 or 6 characters in length" +
                " not including leading '#' character.")
            self.init(red: 0.2, green: 1.0, blue: 0.2)
            return
        }

        // Must be a valid Hexadecimal value
        let validHexChars = CharacterSet(charactersIn: "0123456789ABCDEF")
        let isValid = formattedHex.uppercased().rangeOfCharacter(from: validHexChars.inverted) == nil
        guard isValid else {
            print("Invalid Hexadecimal string: \(formattedHex)")
            self.init(red: 0.2, green: 1.0, blue: 0.2)
            return
        }

        // Turn hex string into UInt, this shouldn't fail due to the valid Hexadecimal check above.
        guard let hexInt = UInt(formattedHex, radix: 16) else {
            self.init(red: 0.2, green: 1.0, blue: 0.2)
            return
        }

        let mask: UInt = 0x0000FF
        let red = Double((hexInt >> 16) & mask) / 255.0
        let green = Double((hexInt >> 8)  & mask) / 255.0
        let blue = Double((hexInt >> 0)  & mask) / 255.0

        self.init(red: red, green: green, blue: blue)
        return
    }

    /// Return an ARGB formatted Hexadecimal `String` representation of the `UIColor` object.
    var argbHexString: String {
        let rgbString = self.rgbHexString.replacingOccurrences(of: "#", with: "")
        let argb = getARGB(self)
        let alpha = Int(argb.alpha * 255)

        return String(format: "#%02X%@", alpha, rgbString)
    }

    /// Return an RGB formatted Hexadecimal `String` representation of the `UIColor` object.
    var rgbHexString: String {
        let argb = getARGB(self)
        let textColor = String(format: "#%02X%02X%02X",
                               Int(argb.red * 255),
                               Int(argb.green * 255),
                               Int(argb.blue * 255))

        return textColor
    }
}

// swiftlint:disable:next large_tuple
private func getARGB(_ color: Color) -> (alpha: CGFloat, red: CGFloat, green: CGFloat, blue: CGFloat) {

    typealias NativeColor = NSColor

    var red: CGFloat = 0
    var green: CGFloat = 0
    var blue: CGFloat = 0
    var alpha: CGFloat = 0

    // Use getRed() instead of cgColor.components because white only returns
    // two components and we would have to special case it.
    let nativeColor = NativeColor(color)
    nativeColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
    return (alpha, red, green, blue)
}
