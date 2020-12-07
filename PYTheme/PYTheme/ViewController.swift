//
//  ViewController.swift
//  PYTheme
//
//  Created by Bob Lee on 2020/11/29.
//

import UIKit

class ViewController: UIViewController {
    var labTitle: UILabel?
    var btnStyle: UIButton?
    var btnStyleCustom: PYButton?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if #available(iOS 13, *) {
            return PYThemeManager.currentUIStyle() == PYUserInterfaceStyle.dark ? .lightContent : .darkContent
        } else {
            return PYThemeManager.currentUIStyle() == PYUserInterfaceStyle.light ? .lightContent : .default
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTheme()
        setupThemeCustom()
    }
    
    func setupUI() {
        let label = UILabel()
        label.frame = CGRect(x: 10, y: 100, width: view.bounds.width-20, height: 30)
        label.text = "Adapt to the dark mode"
        label.textAlignment = .center
        view.addSubview(label)
        labTitle = label
        
        let btn = UIButton()
        btn.frame = CGRect(x: 10, y: 160, width: 250, height: 40)
        btn.setTitle("using system controls", for: .normal)
        btn.addTarget(self, action: #selector(btnClicked(_:)), for: .touchUpInside)
        view.addSubview(btn)
        btnStyle = btn
        
        btnStyleCustom = PYButton()
        btnStyleCustom?.frame = CGRect(x: 10, y: 220, width: 250, height: 40)
        btnStyleCustom?.setTitle("using custom controls", for: .normal)
        btnStyleCustom?.addTarget(self, action: #selector(btnClicked(_:)), for: .touchUpInside)
        view.addSubview(btnStyleCustom!)
    }
    
    @objc private func btnClicked(_ btn: UIButton) {
        if btn == btnStyle {
            present(PYThemeVCUsingSystemView(), animated: true, completion: nil)
        } else {
            present(PYThemeVCUsingCustomView(), animated: true, completion: nil)
        }
    }
}

extension ViewController: PYThemeDelegate {
    /// implement if needed
//    var userInterfaceStyle: PYUserInterfaceStyle { return innerStyle }
    
    func setupTheme() {
        setNeedsStatusBarAppearanceUpdate()
        PYThemeManager.registerVisitor(vistor: self)
        labTitle?.setupStyle(style: PYTextStyle(fontStyle: PYFontStyle(size: PYFontSize.large, isBold: true), colorStyle: .black).autoAdapt())
        btnStyle?.setupStyle(config: [.light: PYButtonStyle.black, .dark: PYButtonStyle.white], state: .normal)
        btnStyle?.setupStyle(config: [.light: PYButtonStyle.white, .dark: PYButtonStyle.black], state: .highlighted)
        view.setupStyle(config: [.light: PYViewStyle.white, .dark: PYViewStyle.black])
    }
    
    func setupThemeCustom() {
        btnStyleCustom?.configStyle(config: { (uiStyle, state) -> PYButtonStyle? in
            switch uiStyle {
                case .light, .unspecified:
                    if state == .normal {
                        return PYButtonStyle.black
                    } else {
                        return PYButtonStyle.white
                    }
                default:
                    if state == .normal {
                        return PYButtonStyle.white
                    } else {
                        return PYButtonStyle.black
                    }
            }
        })
    }
}
