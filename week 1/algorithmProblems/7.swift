
import Foundation

var i:Int
var j:Int
var k:Int
var temp2:Int
var array=[String]()
var length:Int

print("Enter the number of strings")
var temp=readLine()
length=Int(temp!)!//length of the array of strings
print("Enter the Strings")
for i in 0...(length-1) {
    temp=readLine()
    array.append(temp!)
}

var key:String
//Insertion sort

for k in 1...(length-1) {
    key=array[k]
    j=k-1
    while (j>=0 && array[j]>key) {
        array[j+1]=array[j]
        j-=1
    }
    array[j+1]=key
}
print("The sorted list is :")
for temp in array {
    print(temp)
}
