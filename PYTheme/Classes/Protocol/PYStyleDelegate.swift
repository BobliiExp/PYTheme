//
//  PYStyleDelegate.swift
//  PYTheme
//
//  Created by Bob Lee on 2020/12/1.
//

import Foundation

public protocol PYTextStyleDelegate {
    func setupStyle(style: PYTextStyle)
    func setupStyle(style: PYTextStyle, uiStyle: PYUserInterfaceStyle?)
}
