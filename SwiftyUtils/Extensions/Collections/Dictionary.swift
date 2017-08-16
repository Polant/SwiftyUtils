//
//  Dictionary.swift
//  SwiftyUtils
//
//  Created by Anton Poltoratskyi on 11.06.17.
//  Copyright © 2017 Anton Poltoratskyi. All rights reserved.
//

public extension Dictionary {
    
    public init<S: Sequence>(sequence: S) where S.Iterator.Element == (key: Key, value: Value) {
        self = [:]
        self.merge(with: sequence)
    }
    
    public mutating func merge<S>(with sequence: S) where S: Sequence, S.Iterator.Element == (key: Key, value: Value) {
        for (key, value) in sequence {
            self[key] = value
        }
    }
    
    public func mapValues<NewValue>(_ transform: (Value) -> NewValue) -> [Key: NewValue] {
        let pairs = self.map { keyValuePair in
            return (
                key: keyValuePair.key,
                value: transform(keyValuePair.value)
            )
        }
        return Dictionary<Key, NewValue>(sequence: pairs)
    }
    
    public subscript(key: Key, or defaultValue: Value) -> Value {
        get {
            return self[key] ?? defaultValue
        } set(newValue) {
            self[key] = newValue
        }
    }
}
