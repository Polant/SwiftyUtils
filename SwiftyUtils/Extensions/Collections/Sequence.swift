//
//  Sequence.swift
//  SwiftyUtils
//
//  Created by Anton Poltoratskyi on 11.06.17.
//  Copyright © 2017 Anton Poltoratskyi. All rights reserved.
//

public extension Sequence {
    
    public func all(matching predicate: (Iterator.Element) -> Bool) -> Bool {
        return !contains { !predicate($0) }
    }
    
    public func none(matching predicate: (Iterator.Element) -> Bool) -> Bool {
        return !contains { predicate($0) }
    }
    
    public func count(where predicate: (Iterator.Element) -> Bool) -> Int {
        var result = 0
        for element in self where predicate(element) {
            result += 1
        }
        return result
    }
    
    public func last(where predicate: (Iterator.Element) -> Bool) -> Iterator.Element? {
        for element in self.reversed() where predicate(element) {
            return element
        }
        return nil
    }
}

public extension Sequence where Iterator.Element: Equatable, SubSequence: Sequence, SubSequence.Iterator.Element == Iterator.Element {
    
    public func isHeadMirrorsTail(n: Int) -> Bool {
        let head = prefix(n)
        let tail = suffix(n).reversed()
        return head.elementsEqual(tail)
    }
}

public extension Sequence where Iterator.Element: Hashable {
    
    public func unique() -> [Iterator.Element] {
        var seen: Set<Iterator.Element> = []
        return filter { value in
            if seen.contains(value) {
                return false
            } else {
                seen.insert(value)
                return true
            }
        }
    }
    
    public var frequencies: [Iterator.Element: Int] {
        var result: [Iterator.Element: Int] = [:]
        for x in self {
            result[x, or: 0] += 1
        }
        return result
    }
}
