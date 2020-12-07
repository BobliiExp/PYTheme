//
//  PYThemeVCUsingCustomView.swift
//  PYTheme
//
//  Created by Bob Lee on 2020/12/5.
//

import UIKit

class PYThemeVCUsingCustomView: UIViewController {
    var labTitle: PYLabel?
    var btnChangeStyle: PYButton?
    
    override func loadView() {
        let view = PYView()
        view.frame = UIScreen.main.bounds
        self.view = view
        view.configStyle { (uiStyle) -> PYViewStyle in
            switch uiStyle {
                case .light: return PYViewStyle.white
                default: return PYViewStyle.black
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        labTitle = PYLabel(frame: CGRect(x: 10, y: 50, width: 200, height: 30))
        labTitle?.text = "PYLabel"
        view.addSubview(labTitle!)
        labTitle?.configStyle(config: { (uiStyle) -> PYTextStyle in
            switch uiStyle {
                case .light: return PYTextStyle.black
                default: return PYTextStyle.white
            }
        })
        
        btnChangeStyle = PYButton(frame: CGRect(x: 10, y: 100, width: 100, height: 40))
        btnChangeStyle?.setTitle(PYThemeManager.currentUIStyle() == .dark ? "switch to white" : "switch to black", for: .normal)
        btnChangeStyle?.addTarget(self, action: #selector(btnClicked(_:)), for: .touchUpInside)
        view.addSubview(btnChangeStyle!)
        btnChangeStyle?.configStyle(config: { (uiStyle, state) -> PYButtonStyle? in
//            if state == .normal {
//                return PYButtonStyle.common.autoAdapt()
//            } else {
//                return nil
//            }
//            or
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
    
    @objc private func btnClicked(_ btn: UIButton) {
        let uiStyle: PYUserInterfaceStyle = PYThemeManager.currentUIStyle() == .dark ? .light : .dark
        PYThemeManager.updateUserInterfaceStyle(uiStyle)
        btn.setTitle(uiStyle == .dark ? "switch to white" : "switch to black", for: .normal)
    }
}
