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
    "backgroundVC": UIColor(red: 0.961, green: 0.961, blue: 0.961, alpha: 1.0),
    "backgroundVCLight": UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5),
    "backgroundVCDark": UIColor(red: 0.157, green: 0.157, blue: 0.157, alpha: 1.0),
    "black": UIColor(red: 0.157, green: 0.157, blue: 0.157, alpha: 1.0),
    "golden": UIColor(red: 0.898, green: 0.788, blue: 0.714, alpha: 1.0),
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
    /// #f5f5f5 ff(1.0)
    case backgroundVC
    /// #ffffff 7f(0.5)
    case backgroundVCLight
    /// #282828 ff(1.0)
    case backgroundVCDark
    /// #282828 ff(1.0)
    case black
    /// #e4c8b6 ff(1.0)
    case golden
    /// #ffffff ff(1.0)
    case white

    func getColor() -> UIColor {
        return customColors[self.rawValue] ?? UIColor.white
    }
}
