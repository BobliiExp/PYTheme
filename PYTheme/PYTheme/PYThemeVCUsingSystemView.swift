//
//  PYThemeVCUsingSystemView.swift
//  PYTheme
//
//  Created by Bob Lee on 2020/12/5.
//

import UIKit

class PYThemeVCUsingSystemView: UIViewController {
    var labTitle: UILabel?
    var btnStyle: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupTheme()
    }

    func setupUI() {
        let label = UILabel()
        label.frame = CGRect(x: 10, y: 50, width: 100, height: 30)
        label.text = "UILabel"
        view.addSubview(label)
        labTitle = label
        
        let btn = UIButton()
        btn.frame = CGRect(x: 10, y: 100, width: 100, height: 40)
        btn.setTitle(PYThemeManager.currentUIStyle() == .dark ? "go white" : "go black", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.addTarget(self, action: #selector(btnClicked(_:)), for: .touchUpInside)
        view.addSubview(btn)
        btnStyle = btn
    }
    
    @objc private func btnClicked(_ btn: UIButton) {
        let uiStyle: PYUserInterfaceStyle = PYThemeManager.currentUIStyle() == .dark ? .light : .dark
        PYThemeManager.updateUserInterfaceStyle(uiStyle)
        btn.setTitle(uiStyle == .dark ? "go white" : "go black", for: .normal)
    }
}

extension PYThemeVCUsingSystemView: PYThemeDelegate {
    /// implement if needed
    //    var userInterfaceStyle: PYUserInterfaceStyle { return innerStyle }
    
    func setupTheme() {
        PYThemeManager.registerVisitor(vistor: self)
        labTitle?.setupStyle(style: PYTextStyle.common.autoAdapt())
        btnStyle?.setupStyle(config: [.light: PYButtonStyle.black, .dark: PYButtonStyle.white], state: .normal)
        btnStyle?.setupStyle(config: [.light: PYButtonStyle.white, .dark: PYButtonStyle.black], state: .highlighted)
        view.setupStyle(config: [.light: PYViewStyle.white, .dark: PYViewStyle.black])
    }
}
