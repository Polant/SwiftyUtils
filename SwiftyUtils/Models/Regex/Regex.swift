//
//  Regex.swift
//  SwiftyUtils
//
//  Created by Anton Poltoratskyi on 23.07.17.
//  Copyright © 2017 Anton Poltoratskyi. All rights reserved.
//

import Foundation

public struct Regex<V: StringViewSelector> where V.View == String.CharacterView { // V.View.Iterator.Element == Equatable, V.View.SubSequence == V.View {
    fileprivate var regexp: String
    
    init(_ regexp: String) {
        self.regexp = regexp
    }
}

extension Regex: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        self.regexp = value
    }
    public init(extendedGraphemeClusterLiteral value: String) {
        self.init(stringLiteral: value)
    }
    public init(unicodeScalarLiteral value: String) {
        self.init(stringLiteral: value)
    }
}

extension Regex {
    public func match(_ text: String) -> Bool {
        let text = V.view(from: text)
        let regexp = V.view(from: self.regexp)
        
        // if regex starts with "^", then it can only match the
        // start of the input
        if regexp.first == V.caret {
            return Regex.matchHere(regexp: regexp.dropFirst(), text: text)
        }
        var idx = text.startIndex
        while true {
            if Regex.matchHere(regexp: regexp, text: text.suffix(from: idx)) {
                return true
            }
            guard idx != text.endIndex else {
                break
            }
            text.formIndex(after: &idx)
        }
        return false
    }
}

extension Regex {
    /// Match a regular expression string at the beginning of text.
    fileprivate static func matchHere(regexp: V.View, text: V.View) -> Bool {
        // Empty regexprs match everything
        guard !regexp.isEmpty else {
            return true
        }
        
        // Any character followed by * requires a call to matchStar
        if let char = regexp.first, regexp.dropFirst().first == V.asterisk {
            return matchStar(character: char, regexp: regexp.dropFirst(2), text: text)
        }
        
        // If this is the last regex character and it's $, then it's a match iff the 
        // remaining text is also empty
        if regexp.first == V.dollar && regexp.dropFirst().isEmpty {
            return text.isEmpty
        }
        
        // If one character matches, drop one from the input and the regex 
        // and keep matching
        if let textFirst = text.first, let regexpFirst = regexp.first, regexpFirst == V.period || regexpFirst == textFirst {
            return matchHere(regexp: regexp.dropFirst(), text: text.dropFirst())
        }
        return false
    }
}


extension Regex {
    
    /// "*" matches zero or more instances
    fileprivate static func matchStar(character: V.View.Iterator.Element,
                                      regexp: V.View,
                                      text: V.View) -> Bool {
        
        var idx = text.startIndex
        while true {
            if matchHere(regexp: regexp, text: text.suffix(from: idx)) {
                return true
            }
            guard idx != text.endIndex else {
                break
            }
            if text[idx] != character && character != V.period {
                return false
            }
            text.formIndex(after: &idx)
        }
        return false
    }
}

func ~=<T: Equatable>(lhs: T, rhs: T?) -> Bool {
    return lhs == rhs
}


