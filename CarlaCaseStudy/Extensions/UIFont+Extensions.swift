//
//  UIFont+Extensions.swift
//  CarlaCaseStudy
//
//  Created by Talha Batuhan Irmalı on 5.06.2024.
//

import UIKit

extension UIFont {
    enum InterFont: String {
        case regular = "Inter-Regular"
        case regularItalic = "Inter-Regular_Italic"
        case thin = "Inter-Regular_Thin"
        case thinItalic = "Inter-Regular_Thin-Italic"
        case extraLight = "Inter-Regular_ExtraLight"
        case extraLightItalic = "Inter-Regular_ExtraLight-Italic"
        case light = "Inter-Regular_Light"
        case lightItalic = "Inter-Regular_Light-Italic"
        case medium = "Inter-Regular_Medium"
        case mediumItalic = "Inter-Regular_Medium-Italic"
        case semiBold = "Inter-Regular_SemiBold"
        case semiBoldItalic = "Inter-Regular_SemiBold-Italic"
        case bold = "Inter-Regular_Bold"
        case boldItalic = "Inter-Regular_Bold-Italic"
        case extraBold = "Inter-Regular_ExtraBold"
        case extraBoldItalic = "Inter-Regular_ExtraBold-Italic"
        case black = "Inter-Regular_Black"
        case blackItalic = "Inter-Regular_Black-Italic"
    }

    enum QuicksandFont: String {
        case regular = "Quicksand-Regular"
        case light = "Quicksand-Light"
        case medium = "Quicksand-Medium"
        case semiBold = "Quicksand-SemiBold"
        case bold = "Quicksand-Bold"
    }

    static func interFont(_ type: InterFont, size: CGFloat) -> UIFont {
        return UIFont(name: type.rawValue, size: size) ?? UIFont.systemFont(ofSize: size)
    }

    static func quicksandFont(_ type: QuicksandFont, size: CGFloat) -> UIFont {
        return UIFont(name: type.rawValue, size: size) ?? UIFont.systemFont(ofSize: size)
    }
}




