//
//  MutableCollection.swift
//  SwiftyUtils
//
//  Created by Anton Poltoratskyi on 02.08.17.
//  Copyright © 2017 Anton Poltoratskyi. All rights reserved.
//

import Foundation

extension MutableCollection where Self: RandomAccessCollection {
    
    mutating func shuffle() {
        var i = startIndex
        let beforeEndIndex = index(before: endIndex)
        
        while i < beforeEndIndex {
            let distance = self.distance(from: i, to: endIndex)
            let randomDistance = IndexDistance.arc4random_uniform(distance)
            let j = index(i, offsetBy: randomDistance)
            
            guard i != j else { return }
            
            swap(&self[i], &self[j])
            formIndex(after: &i)
        }
    }
}

extension Sequence {
    
    func shuffled() -> [Iterator.Element] {
        var clone = Array(self)
        clone.shuffle()
        return clone
    }
}

extension SignedInteger {
    static func arc4random_uniform(_ upperBound: Self) -> Self {
        precondition(upperBound > 0 && upperBound.toIntMax() < UInt32.max.toIntMax(),
                     "arc4random_uniform only callable up to \(UInt32.max)")
        return numericCast(Darwin.arc4random_uniform(numericCast(upperBound)))
    }
}
