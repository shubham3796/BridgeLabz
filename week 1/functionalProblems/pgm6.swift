//
//  main.swift
//  pgm6
//
//  Created by admin on 21/08/19.
//  Copyright © 2019 admin. All rights reserved.
//

import Foundation

print("Enter the number whose prime factors are to be found")

var i:Int=2

var temp=readLine()
var N=Int(temp!)

while i*i <= N! && N!>2 {
     if N!%i == 0 {
            print(i)
            N = N!/i
            i=2
    }
    else {
        i+=1
    }
}

print(N!)
