//
//  FlieldsDeck.swift
//  BG
//
//  Created by Igor Shelginskiy on 9/2/19.
//  Copyright © 2019 Igor Shelginskiy. All rights reserved.
//

import Foundation

struct FieldsDeck {
    private(set) var matrix = [0:3, 1:4, 2:5, 3:4, 4:3]
    
    var massField:[[Int]] {
        var massField = [[Int]]()
        var kv = [Int]()
        
        for key in matrix.keys.sorted(by: <) {
            for value in 0...matrix[key]!-1 {
                kv.append(key)
                kv.append(value)
                massField.append(kv)
                kv = [Int]()
            }
        }
        return massField
    }
}
