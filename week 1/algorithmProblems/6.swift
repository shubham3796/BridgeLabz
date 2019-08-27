import Foundation

print("Enter the number of strings:")
var temp=readLine()
var sizeofStringArray=Int(temp!)
var i:Int
var j:Int
var k:Int
var array=[String]()
print("Enter the strings:")
var key:String
for i in 0...(sizeofStringArray!-1) {
    temp=readLine()
    array.append(temp!)
}

print("Enter the string you want to search")
var searchString=readLine()

var tempA:String

//Sort the array of strings
for k in 1...(sizeofStringArray!-1) {
    key=array[k]
    j=k-1
    while (j>=0 && array[j]>key) {
        array[j+1]=array[j]
        j-=1
    }
    array[j+1]=key
}
print(array)
//Binary search
    var lowerBound=0
    var upperBound=sizeofStringArray!-1
    var flag=0
    var mid:Int
    
    while(flag==0) {
        mid=(lowerBound+upperBound)/2
        if(mid==lowerBound+1 && upperBound==mid+1)
        {

            if searchString==array[upperBound] {
                print("Found the string")
                flag=1
            }
            else {
                upperBound=lowerBound+1
            }
        }
        else if(mid == lowerBound && upperBound==mid+1)
        {
            
            if searchString==array[lowerBound] {
                print("Found the string")
                flag=1
            }
            else {
                print("Found the string")
                flag=1
            }
        }
        else {
            if searchString!>=array[lowerBound] && searchString!<=array[mid] {
                upperBound=mid
                mid=(lowerBound+upperBound)/2
            }
            else {
                lowerBound=mid+1
                mid=(lowerBound+upperBound)/2
            }
        }
    }
    
    

