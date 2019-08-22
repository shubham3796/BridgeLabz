//
//  main.swift
//  pgm 15
//
//  Created by admin on 21/08/19.
//  Copyright © 2019 admin. All rights reserved.
//

import Foundation

print("Enter a,b,c of equation")
var temp=readLine()
let a=Int(temp!)
temp=readLine()
let b=Int(temp!)
temp=readLine()
let c=Int(temp!)

var delta=0
delta=(b!*b!-(4*a!*c!))

if delta<0 {
    print("No real roots exist")
}
else
{
    var fRoot=((Float(Float(delta).squareRoot())-Float(b!))/Float((2*a!)))
    var sRoot=((Float(Float(delta).squareRoot())+Float(b!))/Float((-2*a!)))
    print("The two values of x are : \(fRoot), \(sRoot)")
}

