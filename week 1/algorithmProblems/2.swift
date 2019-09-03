import Foundation

var arr = [Int]()
var divisor:Int
var number:Int

for number in 0...1000 {
    arr.append(number)
}
var flag=0

print("2")
print("3")
for number in 4...1000 {
    flag = 0
    for divisor in 2...(number/2) {
        if arr[number]%divisor== 0 {//number is not prime, set flag as 1
            flag=1
        }
    }//end for 
    if flag==0 {
        print(number)
    }
}
