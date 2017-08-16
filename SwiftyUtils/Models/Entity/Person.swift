//
//  Person.swift
//  SwiftyUtils
//
//  Created by Anton Poltoratskyi on 11.06.17.
//  Copyright © 2017 Anton Poltoratskyi. All rights reserved.
//

import Foundation

struct CopyTestStruct {
    var person: Person
}

struct Person {
    var name: String
    var zipCode: Int
    var birthday: Date
    
//    var test: CopyTestStruct?     // won't compile
}

extension Person: Equatable {
    static func ==(lhs: Person, rhs: Person) -> Bool {
        return lhs.name == rhs.name
            && lhs.zipCode == rhs.zipCode
            && lhs.birthday == lhs.birthday
    }
}

extension Person: Hashable {
    var hashValue: Int {
        return self.rotateBits(of: name.hashValue)
            ^ zipCode.hashValue
            ^ birthday.hashValue
    }
    
    private func rotateBits(of value: Int) -> Int {
        let intSize = MemoryLayout<Int>.stride
        let count = intSize / 2
        return value << count | value >> count
    }
}
