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
    
    static func getDateComponentsFromDate(_ date:Date)->DateComponents {
        let components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date)
        return components
    }
    
    static func getCurrentDate() -> Date{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy, HH:mm"
        let date: NSDate = dateFormatter.date(from: "28 Nov 2019, 12:24")! as NSDate
        return date as Date
    }
    
    static func getDateInStringFormat(_ date:Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy, HH:mm"
        let stringDate = dateFormatter.string(from: date)
        return stringDate
    }
    
    static func getDatecomponentsInStringFormat(_ dateComponents:DateComponents) -> String {
        return dateComponents.description
    }
    
    static func getDayMonthYearHourMinute(_ date:Date) -> (Int,Int,Int,Int,Int){
        let day = Calendar.current.component(.day,from:date)
        let month = Calendar.current.component(.month, from: date)
        let year = Calendar.current.component(.year, from: date)
        let hour = Calendar.current.component(.hour, from:date)
        let minute = Calendar.current.component(.minute, from: date)
        //let second = Calendar.current.component(.second, from: date)
        return (day,month,year,hour,minute)
    }
}
