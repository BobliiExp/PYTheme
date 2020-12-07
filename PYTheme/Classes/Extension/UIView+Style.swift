//
//  UIView+Style.swift
//  PYTheme
//
//  Created by Bob Lee on 2020/12/7.
//

import UIKit

extension UIView: PYStyleDelegate {
    public typealias PYStyle = PYViewStyle
    
    public func setupStyle(style: PYViewStyle) {
        let adapt = style.autoAdaptIfneeded
        if let bgc = style.backgroundColor {
            backgroundColor = adapt ? bgc.colorHex.adaptUIStyle().getColor() : bgc.color
        }
        if let tintc = style.tintColor {
            tintColor = adapt ? tintc.colorHex.adaptUIStyle().getColor() : tintc.color
        }
        if let layerStyle = style.layerStyle {
            if let cornerR = layerStyle.cornerRadius {
                layer.cornerRadius = cornerR
            }
            if let maskBounds = layerStyle.masksToBounds {
                layer.masksToBounds = maskBounds
            }
            if let borderStyle = layerStyle.borderStyle {
                layer.borderColor = adapt ? borderStyle.color.colorHex.adaptUIStyle().getColor().cgColor : borderStyle.color.color.cgColor
                layer.borderWidth = borderStyle.width
            }
            if let shadowStyle = layerStyle.shadowStyle {
                self.layer.shadowColor = adapt ? shadowStyle.color.colorHex.adaptUIStyle().getColor().cgColor : shadowStyle.color.color.cgColor
                self.layer.shadowOffset = shadowStyle.offset
                self.layer.shadowRadius = shadowStyle.radius
                self.layer.shadowOpacity = Float(shadowStyle.opacity)
            }
        }
        if let clipBounds = style.clipToBounds {
            clipsToBounds = clipBounds
        }
    }
    
    public func setupStyle(config: [PYUserInterfaceStyle : PYViewStyle]) {
        if let style = config[PYThemeManager.currentUIStyle()] {
            setupStyle(style: style)
        } else {
            setupStyle(style: PYViewStyle.error)
        }
    }
}
