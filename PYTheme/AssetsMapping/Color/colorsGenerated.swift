// ••••••••••••••••••
// • GENERATED  FILE FROM ASSETS •
// ••••••••••••••••••

import UIKit

fileprivate let customColors: [String: UIColor] = [

    // • /Users/bob/Documents/GitHub/PYTheme/PYTheme/PYTheme/Assets.xcassets
    "colorTest": UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0),
    "colorTestLight": UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0),
    "colorTestDark": UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0),
    "colorTestIphone": UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0),
    "colorTestLightIphone": UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0),
    "colorTestDarkIphone": UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0),

    // • /Users/bob/Documents/GitHub/PYTheme/PYTheme/Classes/Themes/Colors.xcassets
    "blackPanel": UIColor(red: 0.1568627450980392, green: 0.1568627450980392, blue: 0.1568627450980392, alpha: 1.0),
    "graySpan": UIColor(red: 0.5490196078431373, green: 0.5411764705882353, blue: 0.5411764705882353, alpha: 0.26),
    "whiteListVC": UIColor(red: 0.9607843137254902, green: 0.9607843137254902, blue: 0.9607843137254902, alpha: 1.0),
    "goldenDesc": UIColor(red: 0.9176470588235294, green: 0.803921568627451, blue: 0.7294117647058823, alpha: 0.25),
    "blackBg": UIColor(red: 0.129, green: 0.141, blue: 0.165, alpha: 1.0),
    "grayCancelBg": UIColor(red: 0.914, green: 0.914, blue: 0.914, alpha: 1.0),
    "whiteText": UIColor(red: 0.9647058823529412, green: 0.9647058823529412, blue: 0.9647058823529412, alpha: 1.0),
    "grayText": UIColor(red: 0.7098039215686275, green: 0.7137254901960784, blue: 0.7176470588235294, alpha: 1.0),
    "blackDesc": UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1.0),
    "red": UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0),
    "black": UIColor(red: 0.157, green: 0.157, blue: 0.157, alpha: 1.0),
    "golden": UIColor(red: 0.8980392156862745, green: 0.788235294117647, blue: 0.7137254901960784, alpha: 1.0),
    "orange": UIColor(red: 0.9215686274509803, green: 0.5647058823529412, blue: 0.30196078431372547, alpha: 1.0),
    "gray": UIColor(red: 0.9137254901960784, green: 0.9137254901960784, blue: 0.9137254901960784, alpha: 1.0),
    "white": UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0),
]

/// color define
public enum Color: String { 
    /// #ffffff ff(1.0)
    case colorTest
    /// #ffffff ff(1.0)
    case colorTestLight
    /// #ffffff ff(1.0)
    case colorTestDark
    /// #ffffff ff(1.0)
    case colorTestIphone
    /// #ffffff ff(1.0)
    case colorTestLightIphone
    /// #ffffff ff(1.0)
    case colorTestDarkIphone
    /// #282828 ff(1.0)
    case blackPanel
    /// #8c8a8a 42(0.3)
    case graySpan
    /// #f5f5f5 ff(1.0)
    case whiteListVC
    /// #eacdba 3f(0.2)
    case goldenDesc
    /// #20232a ff(1.0)
    case blackBg
    /// #e9e9e9 ff(1.0)
    case grayCancelBg
    /// #f6f6f6 ff(1.0)
    case whiteText
    /// #b5b6b7 ff(1.0)
    case grayText
    /// #999999 ff(1.0)
    case blackDesc
    /// #ff0000 ff(1.0)
    case red
    /// #282828 ff(1.0)
    case black
    /// #e5c9b6 ff(1.0)
    case golden
    /// #eb904d ff(1.0)
    case orange
    /// #e9e9e9 ff(1.0)
    case gray
    /// #ffffff ff(1.0)
    case white

    func getColor() -> UIColor {
        return customColors[self.rawValue] ?? UIColor.white
    }
}
