//
//  List.swift
//  SwiftyUtils
//
//  Created by Anton Poltoratskyi on 01.07.17.
//  Copyright © 2017 Anton Poltoratskyi. All rights reserved.
//

import Foundation

// MARK: - Collection 

public struct List<Element>: Collection {
    public typealias Index = ListIndex<Element>
    
    public var startIndex: Index
    public var endIndex: Index
    
    public subscript(position: Index) -> Element {
        switch position.node {
        case .end:
            fatalError("Out of range")
        case let .node(element, next: _):
            return element
        }
    }
    
    public func index(after i: Index) -> Index {
        switch i.node {
        case .end:
            fatalError("Out of range")
        case let .node(_, next: next):
            return Index(node: next, tag: i.tag - 1)
        }
    }
}

extension List {
    public var count: Int {
        return startIndex.tag - endIndex.tag
    }
}

extension List {
    public func reversed() -> List<Element> {
        let reversedNodes: ListNode<Element> = self.reduce(.end) { $0.cons($1) }
        return List(
            startIndex: ListIndex(node: reversedNodes, tag: self.count),
            endIndex: ListIndex(node: .end, tag: 0)
        )
    }
}

extension List: ExpressibleByArrayLiteral {
    public init(arrayLiteral elements: Element...) {
        self.startIndex = ListIndex(node: elements.reversed().reduce(.end) { partialList, element in
            partialList.cons(element)
        }, tag: elements.count)
        self.endIndex = ListIndex(node: .end, tag: 0)
    }
}

// MARK: - CustomStringConvertible

extension List: CustomStringConvertible {
    public var description: String {
        let elements = self
            .map { element in String(describing: element) }
            .joined(separator: ", ")
        return "List: \(elements)"
    }
}

// MARK: - Equatable

public func ==<T: Equatable>(lhs: List<T>, rhs: List<T>) -> Bool {
    return lhs.elementsEqual(rhs)
}
//extension List: Equatable where Element: Equatable { }
// Error: Extension of type 'List' with constraints cannot have an inheritance clause


// MARK: - Slices

extension List {
    public subscript(bounds: Range<Index>) -> List<Element> {
        return List(startIndex: bounds.lowerBound, endIndex: bounds.upperBound)
    }
}


// MARK: - Collection's Index

public struct ListIndex<Element>: CustomStringConvertible {
    fileprivate let node: ListNode<Element>
    fileprivate let tag: Int
    
    public var description: String {
        return "ListIndex: \(tag)"
    }
}

extension ListIndex: Comparable {
    public static func ==<T>(lhs: ListIndex<T>, rhs: ListIndex<T>) -> Bool {
        return lhs.tag == rhs.tag
    }
    public static func <<T>(lhs: ListIndex<T>, rhs: ListIndex<T>) -> Bool {
        // startIndex has the highest tag, endIndex the lowest
        return lhs.tag > rhs.tag
    }
}

fileprivate enum ListNode<Element> {
    case end
    indirect case node(Element, next: ListNode<Element>)
    
    func cons(_ x: Element) -> ListNode<Element> {
        return .node(x, next: self)
    }
}
