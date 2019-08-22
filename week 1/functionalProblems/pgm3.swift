//
//  main.swift
//  pgm3
//
//  Created by admin on 20/08/19.
//  Copyright © 2019 admin. All rights reserved.
//

import Foundation

print("Please enter a 4 digit number")
var num = readLine()
var n = Int(num!)

if ((n!/1000) != 0) && ((n!/1000)<10){
    if ( n!%100 == 0 )
    {
        if ( n!%400 == 0)
        {
            print("Leap Year")
        }
        else
        {
            print("Common Year")
        }
    }
        else
        {
            if( n!%4 == 0 ) {
                print("Leap Year")
            }
            else
            {
                print("Common Year")
            }
            
        }
    }
else {
    print("Number should be of 4 digits")
}

