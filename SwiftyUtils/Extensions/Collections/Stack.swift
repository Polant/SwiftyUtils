//
//  Stack.swift
//  SwiftyUtils
//
//  Created by Anton Poltoratskyi on 28.06.17.
//  Copyright © 2017 Anton Poltoratskyi. All rights reserved.
//

import Foundation

protocol Stack {
    associatedtype Element
    
    /// Pushes `x` onto the top of `self` 
    /// - Complexity: Amortized O(1).
    mutating func push(_ element: Element)
    
    /// Removes the topmost element of `self` and returns it,
    /// or `nil` if `self` is empty.
    /// - Complexity: O(1)
    mutating func pop() -> Element?
}

extension Array: Stack {
    mutating func push(_ element: Element) {
        self.append(element)
    }
    mutating func pop() -> Element? {
        return self.popLast()
    }
}
