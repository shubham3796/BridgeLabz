//
//  main.swift
//  pgm11
//
//  Created by admin on 22/08/19.
//  Copyright © 2019 admin. All rights reserved.
//

import Foundation

print("Enter the x coordinate")
var temp=readLine()
var xCoordinate=Int(temp!)

print("Enter the y coordinate")
 temp=readLine()
var yCoordinate=Int(temp!)

var distance:Double
var temp2:Double
var xSquare=(Double(xCoordinate!) * Double(xCoordinate!))
var ySquare=( Double(yCoordinate!) * Double(yCoordinate!))
temp2 = xSquare + ySquare
distance=pow(Double(temp2),0.5)

print("Euclidean distance of this point from origin is :")
print(distance)
