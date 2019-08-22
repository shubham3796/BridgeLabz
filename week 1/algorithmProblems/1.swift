//
//  main.swift
//  algo1
//
//  Created by admin on 22/08/19.
//  Copyright © 2019 admin. All rights reserved.
//

import Foundation

var strA=[Character]()
var strB=[Character]()
strA.append(" ")
strB.append(" ")
var len:Int

print("Enter string 1:")
var temp=readLine()
strA=temp!+strA

print("Enter string 2:")
 temp=readLine()
strB=temp!+strB


var lenA=strA.count
var lenB=strB.count


if lenA==lenB {
    var i:Int
    var j:Int
    var temp2:Character
    
    for i in 0...(lenA-2) {
        for j in i+1...(lenA-1){
            if strA[j]<strA[i] {
                temp2=strA[j]
                strA[j]=strA[i]
                strA[i]=temp2
            }
        }
    }
    
    for i in 0...(lenB-2) {
        for j in i+1...(lenB-1){
            if strB[j]<strB[i] {
                temp2=strB[j]
                strB[j]=strB[i]
                strB[i]=temp2
            }
        }
    }
    
    if strA==strB {
        print("Anagram")
    }
    else{
        print("Not Anagram")
    }
}
else {
    print("Not Anagram")
}
