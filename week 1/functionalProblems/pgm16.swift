//
//  main.swift
//  pgm16
//
//  Created by admin on 22/08/19.
//  Copyright © 2019 admin. All rights reserved.
//

import Foundation

print("Enter t")
var temp=readLine()
var t=Double(temp!)

print("Enter v")
var temp2=readLine()
var v=Double(temp2!)

if (t! > 50.00 || t! < -50.00) {
    print("Invalid t value")
}
if (v! > 120.00 || v! < 3.00) {
    print("Invalid v value")
}

var w=0.00
w+=35.74
w+=0.6215*t!
var temp3=0.4275*t!
temp3-=35.75
var temp4=pow(v!,0.16)
temp3=temp3*temp4
w+=temp3
print("WindChill is \(w)")



