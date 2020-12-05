//
//  main.swift
//  PYTheme
//
//  Created by Bob Lee on 2020/12/5.
//

import Foundation

let fileManager = FileManager.default

// Project base directory
let rootPathURL = URL(fileURLWithPath: fileManager.currentDirectoryPath)
// Directory where the generated file should go
let filePathURL = rootPathURL.appendingPathComponent("AssetsMapping/Color")

extension FileManager {
    /// Enumerates all the sub directories of and url having a given extension.
    ///
    /// - parameter url: The root url
    /// - parameter ext: The extension of the searched subdirectories (without the '.')
    ///
    /// - returns: An array containing all the urls of the subdirectories
    func findSubDirectories(from url: URL, withExtension ext: String) -> [URL] {
        let directoryEnumerator = enumerator(at: url, includingPropertiesForKeys: [.isDirectoryKey])
        var result = [URL]()
        
        while let element = directoryEnumerator?.nextObject() as? URL {
            if (try? element.resourceValues(forKeys: [.isDirectoryKey]).allValues[.isDirectoryKey]) as? Bool == true {
                if element.pathExtension.lowercased() == ext {
                    directoryEnumerator?.skipDescendants()
                    result.append(element)
                }
            }
        }
        
        return result
    }
    
    /// Enumerates all the assets catalogs
    func findAssetsCatalogs(form url: URL) -> [URL] {
        return findSubDirectories(from: url, withExtension: "xcassets")
    }
    
    /// Enumerates all the color sets
    func findColorSets(form url: URL) -> [URL] {
        return findSubDirectories(from: url, withExtension: "colorset")
    }
    
    /// Enumerates all the image sets
    func findImageSets(form url: URL) -> [URL] {
        return findSubDirectories(from: url, withExtension: "imageset")
    }
}

extension String {
    func nsRange(from range: Range<String.Index>) -> NSRange {
        return NSRange(range, in: self)
    }
    
    func range(from nsRange: NSRange) -> Range<String.Index>? {
        guard
            let from16 = utf16.index(utf16.startIndex, offsetBy: nsRange.location, limitedBy: utf16.endIndex),
            let to16 = utf16.index(from16, offsetBy: nsRange.length, limitedBy: utf16.endIndex),
            let from = String.Index(from16, within: self),
            let to = String.Index(to16, within: self)
        else { return nil }
        return from ..< to
    }
    
    func positionOf(sub:String, backwards: Bool = false) -> Int {
        // 如果没有找到就返回-1
        var pos = -1
        if let range = range(of:sub, options: backwards ? .backwards : .literal ) {
            if !range.isEmpty {
                pos = self.distance(from:startIndex, to:range.lowerBound)
            }
        }
        return pos
    }
    
    /// 使用下标截取字符串 例: "示例字符串"[0..<2] 结果是 "示例"
    subscript (r: Range<Int>) -> String {
        get {
            if (r.lowerBound > count) || (r.upperBound > count) { return "截取超出范围" }
            let startIndex = self.index(self.startIndex, offsetBy: r.lowerBound)
            let endIndex = self.index(self.startIndex, offsetBy: r.upperBound)
            return String(self[startIndex..<endIndex])
        }
    }
    
    /// 截取第一个到第任意位置
    ///
    /// - Parameter end: 结束的位值
    /// - Returns: 截取后的字符串
    func stringCut(end: Int) ->String{
        
        if !(end < self.count) { return "截取超出范围" }
        let sInde = index(startIndex, offsetBy: end)
        return String(self[...sInde])
    }
    
    /// 截取第任意位置到结束
    ///
    /// - Parameter end:
    /// - Returns: 截取后的字符串
    func stringCutToEnd(start: Int) -> String {
        if !(start < count) { return "截取超出范围" }
        let sRang = index(startIndex, offsetBy: start)
        //return substring(with: sRang)
        return String(self[sRang...])
    }
    
    /// 字符串任意位置插入
    ///
    /// - Parameters:
    ///   - content: 插入内容
    ///   - locat: 插入的位置
    /// - Returns: 添加后的字符串
    func stringInsert(content: String,locat: Int) -> String {
        if !(locat < count) { return "截取超出范围" }
        let str1 = stringCut(end: locat)
        let str2 = stringCutToEnd(start: locat+1)
        return str1 + content + str2
    }
}

/// Structure matching the `Contents.json` inside a color set
struct ColorSetContent : Decodable {
    let colors : [IdiomColor]
    struct IdiomColor: Decodable {
        let appearances : [Appearance]?
        let color: Color
        var idiom: String = "universal" // iPhone,iPad ...
        struct Color : Decodable {
            var components : Components?
            var colorSpace: String = "srgb" // display-p3 ... special key solve later
            
            enum CodingKeys: String, CodingKey{
                case components
                case colorSpace = "color-space"
            }

            init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                components = try values.decode(Components.self, forKey: .components)
                colorSpace = try values.decode(String.self, forKey: .colorSpace)
            }
            
            struct Components : Decodable {
                let red: String
                let green: String
                let blue: String
                let alpha: String
                
                var hexRGBA: String {
                    let r = red.unitComponent
                    let g = green.unitComponent
                    let b = blue.unitComponent
                    let a = alpha.unitComponent
                    let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
                    return String(format: "#%06x %02x(%.1f)", rgb, (Int)(a*255), a)
                }
            }
        }
        struct Appearance : Decodable {
            var appearance: String = "luminosity" // contrast ...
            var value: String = "any" // dark, light ...
        }
    }
    
    /// Loads the content of a color set content file
    ///
    /// - parameter jsonPath: The path to the json content file
    init(jsonPath : String) throws {
        let data = try Data(contentsOf: URL(fileURLWithPath: jsonPath))
        let decoder = JSONDecoder()
        self = try decoder.decode(ColorSetContent.self, from: data)
    }
    
    /// The default color components for a color set (the one without a specified appearcance)
    var defaultComponents : IdiomColor.Color.Components? {
        return colors.filter { $0.appearances == nil }.first?.color.components
    }
}

extension String {
    /// The double value, reduced to 1 when the string is a hexadecimal value
    ///
    /// If the string is a double, returns the double value.
    /// If it contains a 'x', it assumes it's an hexadecimal value and returns the value divided by 255.
    /// Returns 0 otherwise.
    var unitComponent : Double {
        guard let double = Double(self)
        else { return 0.0 }
        
        if contains("x") {
            return double / 255.0
        } else if double > 1.0 {
            return double / 255.0
        }
        else {
            return double
        }
    }
}

let wrap = "\n"
let leftSpace = "    "
let declaration = "    /// "
let remark = "    // "
let remarkSign = "    // • "

/// Header of the generated file
var fileContent = """
// ••••••••••••••••••
// • GENERATED  FILE FROM ASSETS •
// ••••••••••••••••••

import UIKit

fileprivate let customColors: [String: UIColor] = [

"""

var defineContent = """
/// color define
public enum Color: String { \(wrap)
"""

/// Finds all the assets catalogs
let catalogs = fileManager.findAssetsCatalogs(form: rootPathURL)

for catalog in catalogs {
    let relativePath = catalog.relativePath
    var hadAddedCategory = false
    
    /// Find all the color sets of the catalog
    let colorSets = fileManager.findColorSets(form: catalog)
    for colorSet in colorSets {
        if !hadAddedCategory {
            fileContent += "\n\(remarkSign)\(relativePath)\(wrap)"
            hadAddedCategory = true
        }
        let content = colorSet.appendingPathComponent("Contents.json").path
        guard fileManager.fileExists(atPath: content) else { continue }
        
        let name = colorSet.deletingPathExtension().lastPathComponent
        guard
            let setContent = try? ColorSetContent(jsonPath: content),
            !setContent.colors.isEmpty else {
            fileContent += "\(remark)JSON Parsing error on color \"\(name)\"\(wrap)"
            continue
        }
        for color in setContent.colors {
            if let components = color.color.components {
                let idiom = color.idiom == "universal" ? "" : color.idiom.capitalized
                if let appearances = color.appearances, !appearances.isEmpty {
                    for appear in appearances {
                        let appearDesc = appear.appearance[0..<min(appear.appearance.count, 4)].capitalized
                        let defName = "\(name)\(appear.value.capitalized)\(idiom)\(appear.appearance == "luminosity" ? "" : appearDesc)"
                        fileContent += "\(leftSpace)\"\(defName)\": UIColor(red: \(components.red.unitComponent), green: \(components.green.unitComponent), blue: \(components.blue.unitComponent), alpha: \(components.alpha.unitComponent)),\(wrap)"
                        defineContent += "\(declaration)\(components.hexRGBA)\(wrap)"
                        defineContent += "\(leftSpace)case \(defName)\(wrap)"
                    }
                } else {
                    fileContent += "\(leftSpace)\"\(name)\(idiom)\": UIColor(red: \(components.red.unitComponent), green: \(components.green.unitComponent), blue: \(components.blue.unitComponent), alpha: \(components.alpha.unitComponent)),\(wrap)"
                    
                    defineContent += "\(declaration)\(components.hexRGBA)\(wrap)"
                    defineContent += "\(leftSpace)case \(name)\(idiom)\(wrap)"
                }
            }
        }
    }
}

/// Closing the final bracket
fileContent += "]\(wrap)"
defineContent += """

    func getColor() -> UIColor {
        return customColors[self.rawValue] ?? UIColor.white
    }\n
"""
defineContent += "}\(wrap)"
fileContent += "\(wrap)\(defineContent)"

print(fileContent)

do {
    /// Creates the destination directory if it does not exist
    if !fileManager.fileExists(atPath: filePathURL.path) {
        try fileManager.createDirectory(at: filePathURL, withIntermediateDirectories: true, attributes: nil)
    }
    
    /// Writes the generated file
    try fileContent.write(to: filePathURL.appendingPathComponent("colorsGenerated.swift"), atomically: true, encoding: .utf8)
    
    print("✅ File Saved to \(filePathURL.path)")
}
catch {
    print(error)
    exit(1)
}
