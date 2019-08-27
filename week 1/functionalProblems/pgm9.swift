//
//  main.swift
//  pgm9
//
//  Created by admin on 22/08/19.
//  Copyright © 2019 admin. All rights reserved.
//

import Foundation

var array=[[Int]]()
var i:Int

for i in 0...3{
    array.append([])
    for j in 0...2{
        array[i].append(i+j)
    }
}

for i in 0...3{
    print(array[i])
}



