//
//  main.swift
//  pgm2
//
//  Created by admin on 20/08/19.
//  Copyright © 2019 admin. All rights reserved.
//

import Foundation

print("Enter the number of times to flip the coin")
let N = readLine()

var num=Int(N!)         //This type casting is important to manipulate non-string inputs
var i=0

var headCount:Int = 0
var tailCount:Int = 0
var temp=1
print( type(of: N) )
if( num! > 0 )
{
        while i < num!  {
            if (Float.random(in: 0...1) < 0.5){
                tailCount += 1
            }
            else {
                headCount += 1
            }
            i=i+1
        }

var headPerc:Float
var tailPerc:Float

headPerc = 100*((Float(headCount))/Float((headCount + tailCount)))  //Typecasting is noticable
tailPerc = 100*((Float(tailCount))/Float((headCount + tailCount)))

print("Percentage of Heads = \(headPerc)%")
print("Percentage of Tails = \(tailPerc)%")
}
else
{
    print("This value should be a positive integer")
}
