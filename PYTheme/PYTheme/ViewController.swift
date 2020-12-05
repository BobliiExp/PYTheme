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
    var innerStyle: PYUserInterfaceStyle = .dark
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTheme()
    }
    
    func setupUI() {
        let rootPath = FileManager.default.currentDirectoryPath
        
        var url = URL(fileURLWithPath: "")
        url.lastPathComponent
        
        let label = UILabel()
        label.frame = CGRect(x: 10, y: 100, width: 200, height: 30)
        label.text = "UILabel"
        view.addSubview(label)
        labTitle = label
        
        let btn = UIButton()
        btn.frame = CGRect(x: 10, y: 150, width: 100, height: 40)
        btn.setTitle("style", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.addTarget(self, action: #selector(btnClicked(_:)), for: .touchUpInside)
        view.addSubview(btn)
        btnStyle = btn
    }
    
    @objc private func btnClicked(_ btn: UIButton) {
        innerStyle = innerStyle == .dark ? .light : .dark
        PYThemeManager.updateUserInterfaceStyle(innerStyle)
    }
}

extension ViewController: PYThemeDelegate {
    /// implement if needed
//    var userInterfaceStyle: PYUserInterfaceStyle { return innerStyle }
    
    func setupTheme() {
        PYThemeManager.registerVisitor(vistor: self)
        labTitle?.setupStyle(style: PYTextStyle.title, uiStyle: nil)
        labTitle?.setupStyle(style: PYTextStyle.title)
    }
}
