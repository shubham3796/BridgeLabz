import Foundation

print("Enter a number:")
var temp=readLine()
var max=Int(temp!)

print("Think of a number between 0 and \(max!-1).")
print("Type Enter if thought")
var tempA:String
var tempB=readLine()

if tempB=="" {
    
    print("Let me guess the number.")
    
    var lowerBound=0
    var upperBound=max!-1
    var flag=0
    var mid:Int
    
    while(flag==0) {
        mid=(lowerBound+upperBound)/2
        if(mid==lowerBound+1 && upperBound==mid+1)
        {
            print("Enter 1 if number is \(upperBound), and 0 otherwise:")
            tempA=readLine()!
            if tempA=="1" {
                print("Found the number \(upperBound)")
                flag=1
            }
            else {
                upperBound=lowerBound+1
            }
        }
        else if(mid == lowerBound && upperBound==mid+1)
        {
            print("Enter 1 if number is \(lowerBound), and 0 otherwise:")
            tempA=readLine()!
            if tempA=="1" {
                print("Found the number \(lowerBound)")
                flag=1
            }
            else {
                print("Found the number \(upperBound)")
                flag=1
            }
        }
        else {
        
        print("Enter 1 if number is between \(lowerBound) and \(mid), and 0 otherwise:")
            tempA=readLine()!
        if tempA=="1" {
            upperBound=mid
            mid=(lowerBound+upperBound)/2
        }
        else {
            lowerBound=mid+1
            mid=(lowerBound+upperBound)/2
        }
        }
    }
        
    
}
