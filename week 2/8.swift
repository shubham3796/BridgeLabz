/*A Function that returns the index of the day
 of the date- day/month/year
 For e.g-
 
 Index     Day
 0         Sunday
 1         Monday
 2         Tuesday
 3         Wednesday
 4         Thursday
 5         Friday
 6         Saturday*/
func dayNumber(day:Int,month:Int,year:Int) -> Int
{
    let t = [0,3,2,5,0,3,5,1,4,6,2,4]
    //static int t[] = { 0, 3, 2, 5, 0, 3, 5, 1,
    //    4, 6, 2, 4 };
    var temp=year
    if month < 3 {
        temp -= month
    }
    return ( temp + temp/4 - temp/100 +
        temp/400 + t[month-1] + day) % 7;
}

/*
 A Function that returns the name of the month
 with a given month number
 
 Month Number     Name
 0                January
 1                February
 2                March
 3                April
 4                May
 5                June
 6                July
 7                August
 8                September
 9                October
 10               November
 11               December */
func getMonthName(monthNumber:Int) -> String
{
    var months = ["January", "February", "March", "April", "May", "June", "July", "August", "September",
                  "October", "November", "December"]
    
    return (months[monthNumber]);
}

/* A Function to return the number of days in
 a month
 
 Month Number     Name        Number of Days
 0                January     31
 1                February    28 (non-leap) / 29 (leap)
 2                March       31
 3                April       30
 4                May         31
 5                June        30
 6                July        31
 7                August      31
 8                September   30
 9                October     31
 10               November    30
 11               December    31
 
 */
func numberOfDays (monthNumber:Int,year:Int) -> Int
{
    // January
    if (monthNumber == 0) {
        return (31)
    }
    
    // February
    if (monthNumber == 1)
    {
        // If the year is leap then February has
        // 29 days
        if (year % 400 == 0 ||
            (year % 4 == 0 && year % 100 != 0)) {
            return (29)
        }
        else {
            return (28)
        }
    }
    
    // March
    if (monthNumber == 2) {
        return (31)
    }
    
    // April
    if (monthNumber == 3) {
        return (30)
    }
    
    // May
    if (monthNumber == 4) {
        return (31)
    }
    
    // June
    if (monthNumber == 5) {
        return (30)
    }
    
    // July
    if (monthNumber == 6) {
        return (31)
    }
    
    // August
    if (monthNumber == 7) {
        return (31)
    }
    
    // September
    if (monthNumber == 8) {
        return (30)
    }
    
    // October
    if (monthNumber == 9) {
        return (31)
    }
    
    // November
    if (monthNumber == 10) {
        return (30)
    }
    
    // December
    if (monthNumber == 11) {
        return (31)
    }
    return 0
}

// Function to print the calendar of the given year
func printCalendar(year:Int,month:Int)
{
    print ("       Calendar - \(getMonthName(monthNumber: month)), \(year)");
    var days:Int
    // Index of the day from 0 to 6
    var current = dayNumber (day: 1, month: month, year: year);
    
    
    days = numberOfDays (monthNumber: month, year: year);
    //print(days)

    // Print the current month name
    //  print("\n  ------------\(month)-------------\n)")
    // Print the columns
    print("  Sun  Mon  Tue  Wed  Thu  Fri  Sat")
    
    // Print appropriate spaces
    var k=0
    var l=0
    var rowContent = String()
    
    for k in 0...(current-1) {
        for l in 0...4 {
            rowContent += " "
        }
    }
var j=1
    while j != days
    {
        //var rowContent = String()
        
        if current != 7 {
            if j/10 == 0 {//Date is a one digit number
                for l in 0...3 {
                    rowContent += " "
                }
            }
            else {//Date is a two digit number
                for l in 0...2 {
                    rowContent += " "
                }
            }
            rowContent += "\(j)"
            //        k+=1
            //        if (k > 6)
            //        {
            //            k = 0
            //            print(rowContent)
            //        }
            current+=1
        }
        else {
            print(rowContent)
            current=0
            rowContent=String()
            j-=1
        }
        j+=1
    }

//if k != 0 {
//    print("")
//}

// current = k
return
}

// Driver Program to check above funtions
var year = 2018
var month = 9//represents september
printCalendar(year: year,month: month)

