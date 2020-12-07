//
//  PYView.swift
//  PYTheme
//
//  Created by Bob Lee on 2020/12/7.
//

import UIKit

class PYView: UIView {
    var styleConfig: ((_ uiStyle: PYUserInterfaceStyle) -> PYViewStyle)?
    
    var userInterfaceStyle: PYUserInterfaceStyle = .unspecified
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        PYThemeManager.registerVisitor(vistor: self)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        PYThemeManager.registerVisitor(vistor: self)
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        styleConfig = nil
    }
    
}

extension PYView: PYThemeDelegate {
    
    /// 通过闭包让外界可以处理不同情况的样式
    /// - Parameter config: 不同style下的样式配置回调
    public func configStyle(config: @escaping (_ uiStyle: PYUserInterfaceStyle) -> PYViewStyle) {
        styleConfig = config
        let uiStyle = userInterfaceStyle == .unspecified ? PYThemeManager.currentUIStyle() : userInterfaceStyle
        setupStyle(style: config(uiStyle))
    }
    
    public func didThemeChanged(_ uiStyle: PYUserInterfaceStyle) {
        if let style = styleConfig?(uiStyle) {
            setupStyle(style: style)
        }
    }
}
