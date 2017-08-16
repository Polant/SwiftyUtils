//
//  Array.swift
//  SwiftyUtils
//
//  Created by Anton Poltoratskyi on 11.06.17.
//  Copyright © 2017 Anton Poltoratskyi. All rights reserved.
//

public extension Array {
    
    public func indices(where predicate: (Iterator.Element) -> Bool) -> [Index] {
        return self.indices.filter { index in
            predicate(self[index])
        }
    }
    
    // mutation and stateful closure
    public func accumulate<Result>(_ initialResult: Result, _ nextPartialResult: (Result, Element) -> Result) -> [Result] {
        var result = initialResult
        return self.map { element in
            result = nextPartialResult(result, element)
            return result
        }
    }
    
    public subscript(safe idx: Int) -> Element? {
        return idx < endIndex ? self[idx] : nil
    }
    
    public func reduce(_ nextPartialResult: (Element, Element) -> Element) -> Element? {
        // first will be nil if the array is empty
        guard let fst = first else {
            return nil
        }
        return dropFirst().reduce(fst, nextPartialResult)
        
//        // Или еще проще
//        return first.map {
//            dropFirst().reduce($0, nextPartialResult)
//        }
    }
}

extension Array where Element: Comparable {
    
    // Stable merge sort
    mutating func mergeSort() {
        // Define the temporary storage for use by all merges
        var tmp: [Element] = []
        tmp.reserveCapacity(count)
        
        func merge(lo: Int, mi: Int, hi: Int) {
            
            tmp.removeAll(keepingCapacity: true)
            
            var i = lo, j = mi
            while i != mi && j != hi {
                if self[j] < self[i] {
                    tmp.append(self[j])
                    j += 1
                } else {
                    tmp.append(self[i])
                    i += 1
                }
            }
            tmp.append(contentsOf: self[i..<mi])
            tmp.append(contentsOf: self[j..<hi])
            
            replaceSubrange(lo..<hi, with: tmp)
        }

        let n = count
        var size = 1
        while size < n {
            for lo in stride(from: 0, to: n - size, by: size * 2) {
                merge(lo: lo, mi: (lo + size), hi: Swift.min(lo + size * 2, n))
            }
            size *= 2
        }
    }
}

extension Array {
    /// Returns the  rst index where `value` appears in `self`, or `nil`,
    /// if `value` is not found. ///
    /// - Requires: `areInIncreasingOrder` is a strict weak ordering over the
    /// elements in `self`, and the elements in the array are already
    /// ordered by it.
    /// - Complexity: O(log `count`) 
    func binarySearch(for value: Element, areInIncreasingOrder: (Element, Element) -> Bool) -> Int? {
        var left = 0
        var right = count - 1
        while left <= right {
            
            let mid = (left + right) / 2
            let candidate = self[mid]
            
            if areInIncreasingOrder(candidate,value) {
                left = mid + 1
            } else if areInIncreasingOrder(value,candidate) {
                right = mid - 1
            } else {
                // If neither element comes before the other, they _must_ be
                // equal, per the strict ordering requirement of areInIncreasingOrder 
                return mid
            }
        }
        return nil
    }
}

extension Array where Element: Comparable {
    
    func binarySearch(for value: Element) -> Int? {
        return self.binarySearch(for: value, areInIncreasingOrder: <)
    }
}

extension RandomAccessCollection {
    
}
