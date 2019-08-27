
import Foundation

var i:Int
var j:Int
var temp2:Int
var array=[Int]()
var length:Int

print("Enter the number of integers")
var temp=readLine()
length=Int(temp!)!
print("Enter the integers")
for i in 0...(length-1) {
    temp=readLine()
    array.append(Int(temp!)!)
}
//Bubble sort
print("The sorted list is :")
for i in 0...(length-2) {
    for j in 0...(length-i-2){
        if array[j]>array[j+1] {
            temp2=array[j+1]
            array[j+1]=array[j]
            array[j]=temp2
        }
    }
}

for temp in array {
    print(temp)
}
