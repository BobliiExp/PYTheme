//
//  PYButton.swift
//  PYTheme
//
//  Created by Bob Lee on 2020/12/7.
//

import UIKit

class PYButton: UIButton {
    var styleConfig: ((_ uiStyle: PYUserInterfaceStyle, _ state: UIControl.State) -> PYButtonStyle?)?
    
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

extension PYButton: PYThemeDelegate {
    
    /// 通过闭包让外界可以处理不同情况的样式
    /// - Parameter config: 不同style下的样式配置回调
    public func configStyle(config: @escaping (_ uiStyle: PYUserInterfaceStyle, _ state: UIControl.State) -> PYButtonStyle?) {
        styleConfig = config
        adaptState()
    }
    
    private func adaptState() {
        let uiStyle = userInterfaceStyle == .unspecified ? PYThemeManager.currentUIStyle() : userInterfaceStyle
        if let style = styleConfig?(uiStyle, .normal) {
            setupStyle(style: style, state: .normal)
        }
        if let style = styleConfig?(uiStyle, .selected) {
            setupStyle(style: style, state: .selected)
        }
        if let style = styleConfig?(uiStyle, .disabled) {
            setupStyle(style: style, state: .disabled)
        }
        if let style = styleConfig?(uiStyle, .highlighted) {
            setupStyle(style: style, state: .highlighted)
        }
    }
    
    public func didThemeChanged(_ uiStyle: PYUserInterfaceStyle) {
        adaptState()
    }
}
