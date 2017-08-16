//
//  Collection.swift
//  SwiftyUtils
//
//  Created by Anton Poltoratskyi on 16.07.17.
//  Copyright © 2017 Anton Poltoratskyi. All rights reserved.
//

import Foundation

struct RangeStart<T> {
    var start: T
}
struct RangeEnd<T> {
    var end: T
}

postfix operator ..<
postfix func ..<<T>(lhs: T) -> RangeStart<T> {
    return RangeStart(start: lhs)
}

prefix operator ..<
prefix func ..<<T>(rhs: T) -> RangeEnd<T> {
    return RangeEnd(end: rhs)
}

extension Collection {
    /// collection[start..<]
    subscript(rangeStart: RangeStart<Index>) -> SubSequence {
        return self.suffix(from: rangeStart.start)
    }
    /// collection[..<end]
    subscript(rangeEnd: RangeEnd<Index>) -> SubSequence {
        return self.prefix(upTo: rangeEnd.end)
    }
}

extension Collection where Iterator.Element: Equatable, SubSequence.Iterator.Element == Iterator.Element, Indices.Iterator.Element == Index {
    
    func search<Other: Sequence>(for pattern: Other) -> Index? where Other.Iterator.Element == Iterator.Element {
        return self.indices.first { idx in
            return self.suffix(from: idx).starts(with: pattern)
        }
    }
}
