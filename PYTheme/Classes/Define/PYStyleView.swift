//
//  PYStyleDefine.swift
//  PYTheme
//
//  Created by Bob Lee on 2020/12/1.
//

import UIKit

public struct PYViewStyle: PYStyleAdaptDelegate {
    typealias PYAdaptStyle = PYViewStyle
    var autoAdaptIfneeded: Bool = false
    
    struct PYLayerStyle {
        
        struct PYBorderStyle {
            let color: PYColorStyle
            let width: CGFloat
            let radius: CGFloat
            
            static let common: PYBorderStyle = PYBorderStyle(color: .common, width: PYBorderWidth.normal, radius: PYCornerRadius.small)
        }
        
        struct PYShadowStyle {
            var color: PYColorStyle
            let radius: CGFloat
            let offset: CGSize
            let opacity: CGFloat
            
            static let common: PYShadowStyle = PYShadowStyle(color: .common, radius: PYShadowRadius.middle, offset: PYShadowOffset.toBottom, opacity: PYOpacity.medium1)
        }
        
        let masksToBounds: Bool?
        var cornerRadius: CGFloat? {
            return borderStyle?.radius
        }
        let borderStyle: PYBorderStyle?
        let shadowStyle: PYShadowStyle?
        
        static let common: PYLayerStyle = PYLayerStyle(masksToBounds: true, borderStyle: PYBorderStyle.common, shadowStyle: nil)
    }
    
    var backgroundColor: PYColorStyle?
    var tintColor: PYColorStyle?
    var layerStyle: PYLayerStyle?
    var clipToBounds: Bool?
    
    func autoAdapt() -> PYAdaptStyle {
        var style = self
        style.autoAdaptIfneeded = true
//        var bgc = backgroundColor
//        bgc?.autoAdaptIfneeded = true
//        style.backgroundColor = bgc
//        var tcc = tintColor
//        tcc?.autoAdaptIfneeded = true
        return style
    }
}

extension PYViewStyle {
    static let error: PYViewStyle = PYViewStyle(backgroundColor: .error, tintColor: nil, layerStyle: nil)
    
    static let common: PYViewStyle = PYViewStyle(backgroundColor: .white, tintColor: nil, layerStyle: nil)
    static let white: PYViewStyle = PYViewStyle(backgroundColor: .white, tintColor: nil, layerStyle: nil)
    static let black: PYViewStyle = PYViewStyle(backgroundColor: .black, tintColor: nil, layerStyle: nil)
}
