//
//  PYStyleDelegate.swift
//  PYTheme
//
//  Created by Bob Lee on 2020/12/1.
//

import UIKit

// MARK: - UI控件样式
public protocol PYStyleDelegate {
    associatedtype PYStyle
    
    /// 一次性设置样式，不会去适配风格
    /// - Parameter style: 样式
    func setupStyle(style: PYStyle)
    
    /// 设置样式配置表
    /// - Parameter config: 配置信息，内部会根据当前系统风格进行适配
    func setupStyle(config: [PYUserInterfaceStyle: PYStyle])
}

// MARK: - 文本样式
public protocol PYTextStyleDelegate: PYStyleDelegate {
    //    /// 一次性设置样式，不会去适配风格
    //    /// - Parameter style: 文字样式
    //    func setupStyle(style: PYTextStyle)
    //
    //    /// 设置样式配置表
    //    /// - Parameter config: 配置信息，内部会根据当前系统风格进行适配
    //    func setupStyle(config: [PYUserInterfaceStyle: PYTextStyle])
    //
    //    /// 设置样式
    //    /// - Parameters:
    //    ///   - style: 文字样式
    //    ///   - autoAdapt: 是否自动根据样式中可适配的属性进行风格适配
    //    func setupStyle(style: PYTextStyle, autoAdapt: Bool)
}

public protocol PYButtonStyleDelegate: PYTextStyleDelegate {
    func setupStyle(config: [PYUserInterfaceStyle: PYButtonStyle], state: UIControl.State)
}
