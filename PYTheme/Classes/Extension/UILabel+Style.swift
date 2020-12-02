//
//  UILabel+Style.swift
//  PYTheme
//
//  Created by Bob Lee on 2020/12/1.
//

import Foundation
import UIKit

extension UILabel: PYThemeDelegate {
    
}

extension UILabel: PYTextStyleDelegate {
    public func setupStyle(style: PYTextStyle) {
        setupStyle(style: style, uiStyle: nil)
    }
    
    public func setupStyle(style: PYTextStyle, uiStyle: PYUserInterfaceStyle?) {
        font = style.fontStyle.font
        textColor = style.colorStyle.adaptUIStyle(uiStyle).color
    }
}
