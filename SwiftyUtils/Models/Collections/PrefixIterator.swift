//
//  PrefixIterator.swift
//  SwiftyUtils
//
//  Created by Anton Poltoratskyi on 01.07.17.
//  Copyright © 2017 Anton Poltoratskyi. All rights reserved.
//

import Foundation

struct PrefixIterator<Base: Collection>: IteratorProtocol, Sequence {
    let base: Base
    var offset: Base.Index
    
    init(_ base: Base) {
        self.base = base
        self.offset = base.startIndex
    }
    
    mutating func next() -> Base.SubSequence? {
        guard offset != base.endIndex else { return nil }
        base.formIndex(after: &offset)
        return base.prefix(upTo: offset)
    }
}
