//
//  FontExtension.swift
//  Kiwni
//
//  Created by Shubham Shinde on 10/05/22.
//

import Foundation
import UIKit

public enum PopinsStyle: String {
    case black = "-Black"
    case blackItalic = "-BlackItalic"
    case bold = "-Bold"
    case boldItalic = "-BoldItalic"
    case extraBold = "-ExtraBold"
    case extrtaBoldItalic = "-ExtraBoldItalic"
    case extraLight = "-ExtraLight"
    case extraLightItalic = "-ExtraLightItalic"
    case italic = "-Italic"
    case light = "-Light"
    case lightItalic = "-LightItalic"
    case medium = "-Medium"
    case medumItalic = "-MediumItalic"
    case regular = "-Regular"
    case semiBold = "-SemiBold"
    case semiBoldItalic = "-SemiBoldItalic"
    case thin = "-Thin"
    case thinItalic = "-ThinItalic"
    case regularr = "-ThinItalicc"
}

extension UIFont {
    static func fontStyle(_ size: CGFloat, _ type: PopinsStyle = .regular) -> UIFont {
        return UIFont(name: "Montserrat\(type.rawValue)", size: size) ?? .systemFont(ofSize: size)
    }
}
