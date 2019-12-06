//
//  UserLoginCredentials.swift
//  loginRegisterPortal
//
//  Created by admin on 21/09/19.
//  Copyright © 2019 admin. All rights reserved.
//

import Foundation

class UserLoginCredentials {
    static var userList = [UserDetails]()
 
    
    static func printList(){
        var i=0
        while i<userList.count {
            print("\(userList[i].userName)  \(userList[i].password)")
            i += 1
        }
    }
}
