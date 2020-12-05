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
let filePathURL = rootPathURL.appendingPathComponent("AssetsMapping/Image")

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
    
    /// Enumerates all the image sets
    func findImageSets(form url: URL) -> [URL] {
        return findSubDirectories(from: url, withExtension: "imageset")
    }
}

/// Structure matching the `Contents.json` inside a color set
struct Contents : Decodable {
    let images : [IdiomColor]
    struct IdiomColor: Decodable {
        let appearances : [Appearance]?
        var filename: String?
        var idiom: String = "universal" // iPhone,iPad ...
        var size: String?
        let scale: String
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
        self = try decoder.decode(Contents.self, from: data)
    }
    
    func isValid() -> Bool {
        return images.first(where: { $0.filename != nil }) != nil
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
// • GENERATED FILE FROM ASSETS •
// ••••••••••••••••••

import UIKit

/// color define
public enum Image: String { \(wrap)

"""

/// Finds all the assets catalogs
let catalogs = fileManager.findAssetsCatalogs(form: rootPathURL)

for catalog in catalogs {
    let relativePath = catalog.relativePath
    var hadAddedCategory = false
    
    /// Find all the color sets of the catalog
    let sets = fileManager.findImageSets(form: catalog)
    for set in sets {
        if !hadAddedCategory {
            fileContent += "\(remarkSign)\(relativePath)\(wrap)"
            hadAddedCategory = true
        }
        let content = set.appendingPathComponent("Contents.json").path
        guard fileManager.fileExists(atPath: content) else { continue }
        
        let name = set.deletingPathExtension().lastPathComponent
        guard
            let setContent = try? Contents(jsonPath: content) else {
            fileContent += "\(remark)JSON Parsing error on image \"\(name)\"\(wrap)"
            continue
        }
        
        if !setContent.isValid() {
            fileContent += "\(remark)No file setted to image \"\(name)\"\(wrap)"
            continue
        }
        
        fileContent += "\(leftSpace)case \(name)\(wrap)"
    }
}

/// Closing the final bracket
fileContent +=  "}\(wrap)"

print(fileContent)

do {
    /// Creates the destination directory if it does not exist
    if !fileManager.fileExists(atPath: filePathURL.path) {
        try fileManager.createDirectory(at: filePathURL, withIntermediateDirectories: true, attributes: nil)
    }
    
    /// Writes the generated file
    try fileContent.write(to: filePathURL.appendingPathComponent("imagesGenerated.swift"), atomically: true, encoding: .utf8)
    
    print("✅ File Saved to \(filePathURL.path)")
}
catch {
    print(error)
    exit(1)
}
