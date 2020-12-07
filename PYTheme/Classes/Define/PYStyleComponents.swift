//
//  PYStyleDefine.swift
//  PYTheme
//
//  Created by Bob Lee on 2020/12/1.
//

import UIKit

protocol PYStyleAdaptDelegate {
    associatedtype PYAdaptStyle
    var autoAdaptIfneeded: Bool { get set }
    func autoAdapt() -> PYAdaptStyle
}

public struct PYFontStyle {
    var family: PYFontFamily = .PingFangSC
    var weight: PYFontWeight = .regular
    var face: PYFontFace = .normal
    var size: CGFloat = PYFontSize.middle
    var font: UIFont {
        return UIFont.systemFont(ofSize: size)
    }
    
    init(size: CGFloat, isBold: Bool) {
        self.size = size
        self.weight = isBold ? .bold : .regular
    }
    
    init(size: CGFloat, weight: PYFontWeight = .regular) {
        self.size = size
        self.weight = weight
    }
    
    init(family: PYFontFamily, size: CGFloat = PYFontSize.middle) {
        self.family = family
        self.size = size
    }
    
    init(family: PYFontFamily = .PingFangSC, weight: PYFontWeight = .regular, face: PYFontFace = .normal, size: CGFloat = PYFontSize.middle) {
        self.family = family
        self.weight = weight
        self.face = face
        self.size = size
    }
}

public struct PYColorStyle: PYStyleAdaptDelegate {
    typealias PYAdaptStyle = PYColorStyle
    var autoAdaptIfneeded: Bool = false
    var colorHex: Color = .black
    var opacity: CGFloat = PYOpacity.full
    var color: UIColor {
        return autoAdaptIfneeded ? colorHex.adaptUIStyle().getColor() : colorHex.getColor()
    }
    
    init(colorHex: Color) {
        self.colorHex = colorHex
    }
    
    init(colorHex: Color = .black, opacity: CGFloat = PYOpacity.full) {
        self.colorHex = colorHex
        self.opacity = opacity
    }
    /// 按需进行的颜色值映射
    /// - Parameter uiStyle: 指定的主题风格
    /// - Returns: 颜色值
    func adaptUIStyle(_ uiStyle: PYUserInterfaceStyle? = nil) -> PYColorStyle {
        return PYColorStyle(colorHex: colorHex.adaptUIStyle(uiStyle), opacity: opacity)
    }
    
    func autoAdapt() -> PYAdaptStyle {
        var cStyle = self
        cStyle.autoAdaptIfneeded = true
        return cStyle
    }
}

extension PYColorStyle {
    static let error: PYColorStyle = PYColorStyle(colorHex: .red, opacity: PYOpacity.medium1)
    
    static let common: PYColorStyle = PYColorStyle(colorHex: .black, opacity: PYOpacity.full)
    static let white: PYColorStyle = PYColorStyle(colorHex: .white, opacity: PYOpacity.full)
    static let black: PYColorStyle = PYColorStyle(colorHex: .black, opacity: PYOpacity.full)
}
