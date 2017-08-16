//
//  ErrorHandling.swift
//  SwiftyUtils
//
//  Created by Anton Poltoratskyi on 29.07.17.
//  Copyright © 2017 Anton Poltoratskyi. All rights reserved.
//

import Foundation

extension Optional {
    func or(error: Error) throws -> Wrapped {
        switch self {
        case let x?:
            return x
        case nil:
            throw error
        }
    }
}

enum Result<Value> {
    case success(Value)
    case failure(Error)
}
extension Result {
    func flatMap<NextValue>(transform: (Value) -> Result<NextValue>) -> Result<NextValue> {
        switch self {
        case let .success(value):
            return transform(value)
        case let .failure(error):
            return .failure(error)
        }
    }
}
