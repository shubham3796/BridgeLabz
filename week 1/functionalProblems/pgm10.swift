//
//  main.swift
//  pgm10
//
//  Created by admin on 21/08/19.
//  Copyright © 2019 admin. All rights reserved.
//

import Foundation

print("Enter the number of integers")
var temp=readLine()
var N=Int(temp!)


var arr = [Int]()

var i:Int
var numTriplets=0
print("Enter \(N!) integers")
for i in 1...N!{
    var temp1=readLine()!
   var temp2=Int(temp1)
    arr.append(temp2!)
}
    var k:Int
    var l:Int
    var m:Int
    N!-=1
var K=N!-2
var L=N!-1

    for k in 0...K{
        for l in (k+1)...L{
            for m in (l+1)...N!{
                if arr[k]+arr[l]+arr[m] == 0 {
                    print("\(arr[k])  \(arr[l])  \(arr[m])")
                    numTriplets+=1
                }
            }
        }
    }
    

print("Total number of triplets is \(numTriplets)")
