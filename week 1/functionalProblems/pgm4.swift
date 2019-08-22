//
//  main.swift
//  pgm4
//
//  Created by admin on 20/08/19.
//  Copyright © 2019 admin. All rights reserved.
//

import Foundation

print("ENTER N")
var num = readLine()
var n = Int(num!)
var i:Int


if( n! >= 0  && n! <= 31){
    for i in 0...n! {
        print( ( pow(2,i) ) )
    }
}
else {
    print("This value should be any integer from 1 to 31")
}

