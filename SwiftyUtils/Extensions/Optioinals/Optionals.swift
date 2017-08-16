//
//  Optionals.swift
//  SwiftyUtils
//
//  Created by Anton Poltoratskyi on 03.07.17.
//  Copyright © 2017 Anton Poltoratskyi. All rights reserved.
//

import Foundation

/// Now I can use optionals in 'case' statements
///
///     for i in ["2", "foo", "42", "100"] {
///         switch Int(i) {
///         case 42:
///             print("The meaning of life")
///         case nil:
///             print("Not a number")
///         default:
///             print("A mystery number")
///         }
///     }
///
func ~=<T: Equatable>(pattern: T?, value: T?) -> Bool {
    return pattern == value
}

/// Now I can use optionals in 'case' statements in ranges
///
///     for i in ["2", "foo", "42", "100"] {
///         switch Int(i) {
///         case 0..<10:
///             print("A single digit")
///         case nil:
///             print("Not a number")
///         default:
///             print("A mystery number")
///         }
///     }
///
func ~=<Bound>(pattern: Range<Bound>, value: Bound?) -> Bool {
    return value.map { pattern.contains($0) } ?? false
}
