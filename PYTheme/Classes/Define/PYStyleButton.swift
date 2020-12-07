//
//  PYStyleDefine.swift
//  PYTheme
//
//  Created by Bob Lee on 2020/12/1.
//

import UIKit

public struct PYButtonStyle: PYStyleAdaptDelegate {
    typealias PYAdaptStyle = PYButtonStyle
    var autoAdaptIfneeded: Bool = false
    
    var viewStyle: PYViewStyle
    var textStyle: PYTextStyle
    
    func autoAdapt() -> PYButtonStyle {
        var vStyle = self.viewStyle
        vStyle.autoAdaptIfneeded = true
        var tStyle = textStyle
        tStyle.autoAdaptIfneeded = true
        return PYButtonStyle(autoAdaptIfneeded: true, viewStyle: vStyle, textStyle: tStyle)
    }
}

extension PYButtonStyle {
    static let error = PYButtonStyle(viewStyle: PYViewStyle.error, textStyle: PYTextStyle.error)
    
    static let common = PYButtonStyle(viewStyle: PYViewStyle.common, textStyle: PYTextStyle.common)
    static let white = PYButtonStyle(viewStyle: PYViewStyle.white, textStyle: PYTextStyle.black)
    static let black = PYButtonStyle(viewStyle: PYViewStyle.black, textStyle: PYTextStyle.white)
    
    static let cancel = PYButtonStyle(viewStyle: PYViewStyle.common, textStyle: PYTextStyle.common)
}
