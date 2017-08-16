//
//  RandomAccessCollection.swift
//  SwiftyUtils
//
//  Created by Anton Poltoratskyi on 01.08.17.
//  Copyright © 2017 Anton Poltoratskyi. All rights reserved.
//

import Foundation

extension RandomAccessCollection {
    func binarySearch(for value: Iterator.Element, areInIncreasingOrder: (Iterator.Element, Iterator.Element) -> Bool) -> Index? {
        guard !isEmpty else {
            return nil
        }
        var left = startIndex
        var right = index(before: endIndex)
        
        while left < right {
            let distance = self.distance(from: left, to: right)
            let mid = index(left, offsetBy: distance / 2)
            let candidate = self[mid]
            
            if areInIncreasingOrder(candidate, value) {
                left = index(after: mid)
            } else if areInIncreasingOrder(value, candidate) {
                right = index(before: mid)
            } else {
                return mid
            }
        }
        
        return nil
    }
}

extension RandomAccessCollection where Iterator.Element: Comparable {
    func binarySearch(for value: Iterator.Element) -> Index? {
        return self.binarySearch(for: value, areInIncreasingOrder: <)
    }
}

extension RandomAccessCollection where Iterator.Element: Equatable, Indices.Iterator.Element == Index, SubSequence.Iterator.Element == Iterator.Element, SubSequence.Indices.Iterator.Element == Index {
    
    
    func search<Other: RandomAccessCollection>(for pattern: Other) -> Index? where Other.IndexDistance == IndexDistance, Other.Iterator.Element == Iterator.Element {
        // If pattern is longer, this cannot match, exit early.
        guard !isEmpty && pattern.count <= count else { return nil }
        
        // Otherwise, from the start up to the end
        // less space for the pattern ...
        let stopSearchIndex = index(endIndex, offsetBy: -pattern.count)
        
        // ... check if a slice from this point
        // starts with the pattern.
        return prefix(upTo: stopSearchIndex).indices.first { idx in
            suffix(from: idx).starts(with: pattern)
        }
    }
}
