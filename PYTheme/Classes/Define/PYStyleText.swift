//
//  PYStyleDefine.swift
//  PYTheme
//
//  Created by Bob Lee on 2020/12/1.
//

import UIKit

public struct PYTextStyle: PYStyleAdaptDelegate {
    typealias PYAdaptStyle = PYTextStyle
    var autoAdaptIfneeded: Bool = false
    let fontStyle: PYFontStyle
    let colorStyle: PYColorStyle
    
    func autoAdapt() -> PYAdaptStyle {
        var cStyle = PYColorStyle(colorHex: colorStyle.colorHex, opacity: colorStyle.opacity)
        cStyle.autoAdaptIfneeded = true
        return PYTextStyle(autoAdaptIfneeded: true, fontStyle: fontStyle, colorStyle: cStyle)
    }
}

// MARK: - 常用定义
public extension PYTextStyle {
    static let error: PYTextStyle = PYTextStyle(fontStyle: PYFontStyle(), colorStyle: PYColorStyle(colorHex: .red, opacity: PYOpacity.low))
    static let common = PYTextStyle(fontStyle: PYFontStyle(), colorStyle: PYColorStyle())
    
    static let black = PYTextStyle(fontStyle: PYFontStyle(), colorStyle: PYColorStyle(colorHex: .black, opacity: PYOpacity.full))
    static let white = PYTextStyle(fontStyle: PYFontStyle(), colorStyle: PYColorStyle(colorHex: .white, opacity: PYOpacity.full))
}
