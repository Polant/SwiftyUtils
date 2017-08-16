//
//  StringViewSelector.swift
//  SwiftyUtils
//
//  Created by Anton Poltoratskyi on 26.07.17.
//  Copyright © 2017 Anton Poltoratskyi. All rights reserved.
//

import Foundation

public protocol StringViewSelector {
    associatedtype View: Collection
    
    static var caret: View.Iterator.Element { get }
    static var asterisk: View.Iterator.Element { get }
    static var period: View.Iterator.Element { get }
    static var dollar: View.Iterator.Element { get }
    
    static func view(from string: String) -> View
}

// This is "phantom" types, which only exists at compile time
// and don't actually hold any data.
// MemoryLayout<UTF8ViewSelector>.size returns .zero, because it contains no data.

public struct UTF8ViewSelector {
    
    public static var caret: UInt8 { return UInt8(ascii: "^") }
    public static var asterisk: UInt8 { return UInt8(ascii: "*") }
    public static var period: UInt8 { return UInt8(ascii: ".") }
    public static var dollar: UInt8 { return UInt8(ascii: "$") }
    
    public static func view(from string: String) -> String.UTF8View { return string.utf8 }
}

public struct CharacterViewSelector {
    
    public static var caret: Character { return "^" }
    public static var asterisk: Character { return "*" }
    public static var period: Character { return "." }
    public static var dollar: Character { return "$" }
    
    public static func view(from string: String) -> String.CharacterView { return string.characters }
}
