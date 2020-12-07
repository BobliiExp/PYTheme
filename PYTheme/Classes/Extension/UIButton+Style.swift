//
//  UIButton+Style.swift
//  PYTheme
//
//  Created by Bob Lee on 2020/12/7.
//

import UIKit

extension UIButton: PYButtonStyleDelegate {
    public typealias PYStyle = PYButtonStyle
    
    public func setupStyle(style: PYStyle) {
        setupStyle(style: style, state: .normal)
    }
    
    public func setupStyle(style: PYStyle, state: UIControl.State) {
        titleLabel?.font = style.textStyle.fontStyle.font
        setTitleColor(style.textStyle.colorStyle.color, for: state)
        if state == .normal {
            setupStyle(style: style.viewStyle)
        }
    }
    
    public func setupStyle(config: [PYUserInterfaceStyle: PYStyle]) {
        if let style = config[PYThemeManager.currentUIStyle()] {
            setupStyle(style: style)
        } else {
            setupStyle(style: PYStyle.error)
        }
    }
    
    /// 按钮状态样式配置
    /// - Parameters:
    ///   - config: 主题配置
    ///   - state: 按钮状态
    public func setupStyle(config: [PYUserInterfaceStyle : PYStyle], state: UIControl.State) {
        if let style = config[PYThemeManager.currentUIStyle()] {
            setupStyle(style: style, state: state)
        } else {
            setupStyle(style: PYStyle.error)
        }
    }
}
