//
//  Slice.swift
//  SwiftyUtils
//
//  Created by Anton Poltoratskyi on 01.07.17.
//  Copyright © 2017 Anton Poltoratskyi. All rights reserved.
//

import Foundation

struct CustomSlice<Base: Collection>: Collection {
    
    typealias Index = Base.Index
    typealias IndexDistance = Base.IndexDistance
    
    let collection: Base
    
    var startIndex: Index
    var endIndex: Index
    
    init(base: Base, bounds: Range<Index>) {
        collection = base
        startIndex = bounds.lowerBound
        endIndex = bounds.upperBound
    }
    
    func index(after i: Index) -> Index {
        return collection.index(after: i)
    }
    
    subscript(position: Index) -> Base.Iterator.Element {
        return collection[position]
    }
    
    typealias SubSequence = Slice<Base>
    
    subscript(bounds: Range<Base.Index>) -> Slice<Base> {
        return Slice(base: collection, bounds: bounds)
    }
}
