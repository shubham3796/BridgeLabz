//
//  main.swift
//  algo2
//
//  Created by admin on 22/08/19.
//  Copyright © 2019 admin. All rights reserved.
//

import Foundation

var arr = [Int]()
var i:Int

for i in 0...1000 {
    arr.append(i)
}
var flag=0

print("2")
print("3")
for i in 4...1000 {
    flag = 0
    for j in 2...(i/2) {
        if arr[i]%j == 0 {
            flag=1
        }
    }
    if flag==0 {
        print(i)
    }
}
