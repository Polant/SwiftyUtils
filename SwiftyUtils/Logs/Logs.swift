//
//  Logs.swift
//  SwiftyUtils
//
//  Created by Anton Poltoratskyi on 16.07.17.
//  Copyright © 2017 Anton Poltoratskyi. All rights reserved.
//

import Foundation


func log(condition: Bool,
         message: @autoclosure () -> (String),
         file: String = #file,
         function: String = #function,
         line: Int = #line) {
    
    guard !condition else {
        return
    }
    print("myAssert failed: \(message()), \(file):\(function) (line \(line))")
}
