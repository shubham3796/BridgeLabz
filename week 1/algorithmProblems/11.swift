
import Foundation

class Day{
     static func dayFinder(_ month:Int,_ date:Int,_ year:Int)->Int{
    var x:Int
    var yo:Int//yo actually means y_subscript(o), as given in formula
    var mo:Int
    var ddo:Int//since do is a keyword
    var day:Int
    var y=year
    var m=month
    var d=date
    var tempC=Int(0)

        
    yo=Int(y)-((14-Int(m))/12)
     
    x=0
    x+=yo
    x+=(yo/4)
    x-=(yo/100)
    x+=(yo/400)
        
    mo=12*((14-Int(m))/12)
    mo+=Int(m)
    mo-=2
        
    tempC+=((31*Int(mo))/12)
    tempC+=Int(d)+x
    day=(Int(tempC) % 7)

    return day
    }
    
}

print("Enter the month in number form:")
var tempA=readLine()
var month=Int(tempA!)

print("Enter the date:")
 tempA=readLine()
var date=Int(tempA!)



print("Enter the year:")
 tempA=readLine()
var year=Int(tempA!)

var day=Day.dayFinder(month!,date!,year!)

switch day {
case 0:
    print("Sunday")
case 1:
    print("Monday")
case 2:
    print("Tuesday")
case 3:
    print("Wednesday")
case 4:
    print("Thursday")
case 5:
    print("Friday")
case 6:
    print("Saturday")
default:
    print("Something went wrong")
}

