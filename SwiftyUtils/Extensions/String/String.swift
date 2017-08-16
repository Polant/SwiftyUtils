//
//  String.swift
//  SwiftyUtils
//
//  Created by Anton Poltoratskyi on 23.07.17.
//  Copyright © 2017 Anton Poltoratskyi. All rights reserved.
//

import Foundation

extension String {
    
    func wrapped(after: Int = 70) -> String {
        var i = 0
        let lines = self.characters.split(omittingEmptySubsequences: false) { char -> Bool in
            switch char {
            case "\n", 
                 " " where i >= after:
                i = 0
                return true
            default:
                return false
            }
        }.map(String.init)
        return lines.joined(separator: "\n")
    }
    
    func words(with charset: CharacterSet = .alphanumerics) -> [String] {
        return self.unicodeScalars.split { charset.contains($0) }.map(String.init)
    }
}
