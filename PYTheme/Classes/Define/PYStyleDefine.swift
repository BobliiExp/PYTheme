//
//  PYStyleDefine.swift
//  PYTheme
//
//  Created by Bob Lee on 2020/12/1.
//

import UIKit

public struct PYFontStyle {
    let family: PYFontFamily = .PingFangSC
    let weight: PYFontWeight = .regular
    let face: PYFontFace = .normal
    let size: CGFloat = PYFontSize.middle
    var font: UIFont {
        return UIFont.systemFont(ofSize: size)
    }
}

public struct PYColorStyle {
    var colorHex: PYColorString = .black
    var opacity: CGFloat = PYOpacity.full
    var color: UIColor {
        return UIColor(white: colorHex == .black ? 0 : 1, alpha: opacity)
    }
    
    func adaptUIStyle(_ uiStyle: PYUserInterfaceStyle? = nil) -> PYColorStyle {
        return PYColorStyle(colorHex: colorHex.adaptUIStyle(uiStyle), opacity: opacity)
    }
}

public struct PYTextStyle {
    let fontStyle: PYFontStyle
    let colorStyle: PYColorStyle
}

public extension PYTextStyle {
    static let body = PYTextStyle(fontStyle: PYFontStyle(), colorStyle: PYColorStyle())
    static let title = PYTextStyle(fontStyle: PYFontStyle(), colorStyle: PYColorStyle())
}
