//
//  main.swift
//  new product
//
//  Created by admin on 20/08/19.
//  Copyright © 2019 admin. All rights reserved.
//

import Foundation

print("Please enter your name")
var name = readLine()
var nameLen = name!.count

if ( nameLen >= 3 )
{
    print("Hello \(name!), How are you?" )
}
else{
    print("Name should have atleast 3 characters")
}
