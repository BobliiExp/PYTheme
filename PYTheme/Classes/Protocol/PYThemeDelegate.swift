//
//  PYThemeDelegate.swift
//  PYTheme
//
//  Created by Bob Lee on 2020/11/29.
//

import Foundation

/// 主题风格应用协议
@objc public protocol PYThemeDelegate: NSObjectProtocol {
    
    /// 显示样式，默认不指定跟随变化；如果协议对象实现了此属性，将按照返回值控制样式
    @objc optional var userInterfaceStyle: PYUserInterfaceStyle { get }
    
    /// 配置主题信息，包括字体、颜色、布局等信息，请提取到此方法
    @objc optional func setupTheme()
    
    /// 主题风格变化了
    /// - Parameter uiStyle: 新主题风格
    @objc optional func didThemeChanged(_ uiStyle: PYUserInterfaceStyle)
}
