//
//  dateAndExtension.swift
//  loginRegisterPortal
//
//  Created by admin on 25/11/19.
//  Copyright © 2019 admin. All rights reserved.
//

import Foundation

extension Date{
    static func calculateDate(day:Int,month:Int,year:Int,hour:Int,minute:Int) -> Date{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        let calculatedDate = formatter.date(from: "\(year)/\(month)/\(day) \(hour):\(minute)")
        return calculatedDate!
    }
    
    static func getDayMonthYearHourMinute(_ date:Date)->DateComponents {
        //let calendar = Calendar.current
        let components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date)
//        let day = Calendar.component(.day, from: date)
//        let month = Calendar.component(.month, from: date)
//        let year = Calendar.component(.year, from: date)
//        let hour = Calendar.component(.hour, from:date)
//        let minute = Calendar.component(.minute, from: date)
//        let second = Calendar.component(.second, from: date)
        
        //return (day,month,year,hour,minute,second)
        return components
    }
}
