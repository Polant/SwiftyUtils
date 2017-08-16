//
//  Array+Unsafe.swift
//  SwiftyUtils
//
//  Created by Anton Poltoratskyi on 12.08.17.
//  Copyright © 2017 Anton Poltoratskyi. All rights reserved.
//

import Foundation

typealias Block = (UnsafeRawPointer?, UnsafeRawPointer?) -> Int32

func qsort_block(_ array: UnsafeMutableRawPointer, _ count: Int, _ width: Int, _ f: @escaping Block) {
    var thunk = f
    qsort_r(array, count, width, &thunk) { context, p1, p2 -> Int32 in
        let compatator = context!.assumingMemoryBound(to: Block.self).pointee
        return compatator(p1, p2)
    }
}

extension Array where Element: Comparable {
    mutating func quickSort() {
        qsort_block(&self, self.count, MemoryLayout<Element>.stride) { a, b -> Int32 in
            let l = a!.assumingMemoryBound(to: Element.self).pointee
            let r = b!.assumingMemoryBound(to: Element.self).pointee
            
            if r > l {
                return -1
            } else if r == l {
                return 0
            } else {
                return 1
            }
        }
    }
}
