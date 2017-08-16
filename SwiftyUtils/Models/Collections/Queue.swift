//
//  Queue.swift
//  SwiftyUtils
//
//  Created by Anton Poltoratskyi on 11.06.17.
//  Copyright © 2017 Anton Poltoratskyi. All rights reserved.
//

import Foundation

/// A type that can `enqueue` and `dequeue` elements.
protocol Queue {
    associatedtype Element
    
    mutating func enqueue(_ newElement: Element)
    mutating func dequeue() -> Element?
}

// MARK: - Queue Implementation

/// An ef cient variable-size FIFO queue of elements of type `Element`
struct FIFOQueue<Element>: Queue {
    
    fileprivate var left: [Element] = []
    fileprivate var right: [Element] = []
    
    /// Add an element to the back of the queue.
    /// - Complexity: O(1).
    mutating func enqueue(_ newElement: Element) {
        right.append(newElement)
    }
    
    /// Removes front of the queue.
    /// Returns `nil` in case of an empty queue. 
    /// - Complexity: Amortized O(1). 
    mutating func dequeue() -> Element? {
        if left.isEmpty {
            left = right.reversed() // O(1)
            right.removeAll()
        }
        return left.popLast()
    }
}

// MARK: - Collection Implementation

extension FIFOQueue: Collection {
    
    public var startIndex: Int {
        return 0
    }
    
    public var endIndex: Int {
        return left.count + right.count
    }
    
    func index(after i: Int) -> Int {
        precondition(i < endIndex)
        return i + 1
    }
    
    subscript(position: Int) -> Element {
        precondition((0..<endIndex).contains(position), "Index out of bounds")
        if position < left.endIndex {
            return left[left.count - position - 1]
        } else {
            return right[position - left.count]
        }
    }
}

// MARK: - ExpressibleByArrayLiteral

extension FIFOQueue: ExpressibleByArrayLiteral {
    
    init(arrayLiteral elements: Element...) {
        for element in elements {
            enqueue(element)
        }
    }
}

// MARK: - CustomStringConvertible

extension FIFOQueue: CustomStringConvertible, CustomDebugStringConvertible {
    
    public var description: String {
        // Print contained elements using String(describing:), which favors 
        // CustomStringConvertible
        let elements = map { String(describing: $0) }.joined(separator: ", ")
        return "[\(elements)]"
    }
    
    public var debugDescription: String {
        // Print contained elements using String(re ecting:), which favors 
        // CustomDebugStringConvertible
        let elements = map { String(reflecting: $0) }.joined(separator: ", ")
        return "FIFOQueue: [\(elements)]"
    }
}
