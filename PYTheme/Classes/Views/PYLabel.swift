//
//  PYLabel.swift
//  PYTheme
//
//  Created by Bob Lee on 2020/12/5.
//

import UIKit

class PYLabel: UILabel {
    var stypeConfig: ((_ uiStyle: PYUserInterfaceStyle) -> PYTextStyle)?

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
        stypeConfig = nil
    }
    
}

extension PYLabel: PYThemeDelegate {
    
    /// 通过闭包让外界可以处理不同情况的样式
    /// - Parameter config: 不同style下的样式配置回调
    public func configStyle(config: @escaping (_ uiStyle: PYUserInterfaceStyle) -> PYTextStyle) {
        stypeConfig = config
        let uiStyle = userInterfaceStyle == .unspecified ? PYThemeManager.currentUIStyle() : userInterfaceStyle
        setupStyle(style: config(uiStyle))
    }
    
    public func didThemeChanged(_ uiStyle: PYUserInterfaceStyle) {
        if let style = stypeConfig?(uiStyle) {
            setupStyle(style: style)
        }
    }
}
