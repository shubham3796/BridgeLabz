//
//  main.swift
//  pgm5
//
//  Created by admin on 21/08/19.
//  Copyright © 2019 admin. All rights reserved.
//

import Foundation

print("Enter N")
var temp = readLine()
var N = Int(temp!)

var i:Int
var sum: Float = 0.00

if N != 0 {
for i in 1...N! {
    sum += 1/Float(i)
}

print("\(sum)")
}
else {
    print("N should not be 0")
}
