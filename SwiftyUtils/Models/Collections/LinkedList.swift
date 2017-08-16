//
//  File.swift
//  SwiftyUtils
//
//  Created by Anton Poltoratskyi on 28.06.17.
//  Copyright © 2017 Anton Poltoratskyi. All rights reserved.
//

import Foundation

enum LinkedList<Element> {
    case end
    indirect case node(Element, next: LinkedList<Element>)
}

extension LinkedList {
    func cons(_ element: Element) -> LinkedList {
        return .node(element, next: self)
    }
}

extension LinkedList: ExpressibleByArrayLiteral {
    
    init(arrayLiteral elements: Element...) {
        self = elements.reversed().reduce(.end) { partialList, element -> LinkedList in
            partialList.cons(element)
        }
    }
}

// MARK: - Stack

extension LinkedList: Stack {
    mutating func push(_ element: Element) {
        self = self.cons(element)
    }
    mutating func pop() -> Element? {
        switch self {
        case .end:
            return nil
        case let .node(element, next: list):
            self = list
            return element
        }
    }
}

// MARK: - Sequence

extension LinkedList: Sequence, IteratorProtocol {
    mutating func next() -> Element? {
        return pop()
    }
}
