//
//  PYThemeDefine.swift
//  PYTheme
//
//  Created by Bob Lee on 2020/12/1.
//

import Foundation
import UIKit

// UIUserInterfaceStyle iOS 12以上，此处自己维护一套支持到iOS 11控制
@objc
public enum PYUserInterfaceStyle: Int {
    /// 不确定就是没有设置过，默认采用浅色
    case unspecified = 0
    /// 固定浅色
    case light = 1
    /// 固定深色
    case dark = 2
}


/// 基础选项 - 透明度
public enum PYOpacity {
    static let none: CGFloat     = 0.0
    static let veryLow: CGFloat  = 0.05
    static let low: CGFloat      = 0.30
    static let medium1: CGFloat  = 0.40
    static let medium2: CGFloat  = 0.50
    static let medium3: CGFloat  = 0.60
    static let high: CGFloat     = 0.87
    static let full: CGFloat     = 1.0
}

/// 基础选项 - 颜色
public enum PYColorString: String {
    case black = "#000010"
    case white = "#fffff1"
    case gray = "#cccccc"
    
    func adaptUIStyle(_ uiStyle: PYUserInterfaceStyle? = nil) -> PYColorString {
        let uStyle = uiStyle ?? PYThemeManager.currentUIStyle()
        switch uStyle {
            case .dark: return self == .black ? .white : self
            case .light: return self == .black ? self : .white
            default:
                break
        }
        return self
    }
}

/// 基础选项 - 字体大小
public enum PYFontSize {
    static let extraLarge: CGFloat = 26.0
    static let large: CGFloat = 22.0
    static let middle: CGFloat = 16.0
    static let small: CGFloat = 12.0
    static let extraSmall: CGFloat = 10.0
}

/// 基础选项 - 字体大小
public enum PYFontFamily: String {
    case PingFangSC
}

/// 基础选项 - 字体粗细
public enum PYFontWeight: String {
    /// 特黑
    case heavy
    /// 粗
    case bold
    /// 中黑
    case semibold
    /// 中粗
    case medium
    /// 常规
    case regular
    /// 细
    case light
}

/// 基础选项 - 字体显示
public enum PYFontFace {
    case normal
    case italic
}

/// 基础选项 - 圆角半径大小（非圆形）
public enum PYCornerRadius {
    static let large: CGFloat = 15.0
    static let middle: CGFloat = 10.0
    static let small: CGFloat = 5.0
}

/// 基础选项 - 边框厚度
public enum PYBorderWidth {
    static let thick: CGFloat = 5.0
    static let normal: CGFloat = 2.0
    static let thin: CGFloat = 0.5
}

/// 基础选项 - 阴影方向
public enum PYShadowOffset {
    /// 环绕
    static let around: CGSize = CGSize(width: 3.0, height: 0)
    /// 底部
    static let toBottom: CGSize = CGSize(width: 3.0, height: 0)
    /// 顶部
    static let toTop: CGSize = CGSize(width: 3.0, height: 0)
}

/// 基础选项 - 阴影半径
public enum PYShadowRadius {
    static let large: CGFloat = 15.0
    static let middle: CGFloat = 10.0
    static let small: CGFloat = 5.0
}

