//
//  PYThemeManager.swift
//  PYTheme
//
//  Created by Bob Lee on 2020/11/29.
//

import Foundation
import UIKit

public class PYThemeManager {
    private struct ThemeVistor {
        weak var vistor: PYThemeDelegate?
        var assocKey: String?
    }
    
    private static let shared: PYThemeManager = PYThemeManager()
    private lazy var innerView: UIView = UIView()
    private var innerStyle: PYUserInterfaceStyle = .light {
        didSet {
            userInterfaceStyleChanged()
        }
    }
    /// 全局样式类型
    private(set) var uiStyle: PYUserInterfaceStyle {
        get {
            return innerStyle
        }
        set {
            if newValue != innerStyle {
                innerStyle = newValue
            }
        }
    }
    private var vistors: [ThemeVistor] = []
    private var shouldKeepSystemStyle: Bool = true
    private init() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleAppEnterForground), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    /// 准前台后只会关心系统的样式变化；程序内部手动切换
    @objc private func handleAppEnterForground() {
        guard shouldKeepSystemStyle else { return }
        if #available(iOS 13, *) {
            let style = innerView.overrideUserInterfaceStyle
            if style.rawValue != uiStyle.rawValue, style != .unspecified {
                uiStyle = style == .light ? .light : .dark
            }
        }
    }
}

private extension PYThemeManager {
    func userInterfaceStyleChanged() {
        for vistor in vistors where vistor.vistor != nil {
            if vistor.vistor?.userInterfaceStyle == nil ||
                vistor.vistor?.userInterfaceStyle == .unspecified {
                vistor.vistor?.setupTheme?()
                vistor.vistor?.didThemeChanged?(uiStyle)
            }
        }
    }
}

public extension PYThemeManager {
    static func currentUIStyle() -> PYUserInterfaceStyle {
        return shared.uiStyle
    }
    
    static func updateUserInterfaceStyle(_ style: PYUserInterfaceStyle) {
        shared.uiStyle = style
    }
    
    /// 主风格参考系统类型变化，默认 true
    static func shouldKeepSystemStyle(_ keep: Bool) {
        shared.shouldKeepSystemStyle = keep
    }
    
    /// 注册需要关心主题变化的对象
    /// - Note: 如果对象重写了userInterfaceStyle，将不会受到统一风格影响
    /// - Parameters:
    ///   - vistor: 访问主题的对象
    ///   - assocKey: 对象关联唯一值
    static func registerVisitor(vistor: PYThemeDelegate) {
        guard !shared.vistors.contains(where: { $0.vistor?.isEqual(vistor) ?? false }) else {
            return
        }
        shared.vistors.append(ThemeVistor(vistor: vistor))
    }
}
