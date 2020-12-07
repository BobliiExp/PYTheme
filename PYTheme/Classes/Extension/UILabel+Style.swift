//
//  UILabel+Style.swift
//  PYTheme
//
//  Created by Bob Lee on 2020/12/1.
//

import UIKit

extension UILabel: PYTextStyleDelegate {
    public typealias PYStyle = PYTextStyle
    
    public func setupStyle(style: PYTextStyle) {
        font = style.fontStyle.font
        textColor = style.autoAdaptIfneeded ? style.colorStyle.colorHex.adaptUIStyle().getColor() : style.colorStyle.color
    }
    
    public func setupStyle(config: [PYUserInterfaceStyle: PYTextStyle]) {
        if let style = config[PYThemeManager.currentUIStyle()] {
            setupStyle(style: style)
        } else {
            setupStyle(style: PYTextStyle.error)
        }
    }
}
