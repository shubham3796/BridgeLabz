
import Foundation

var arr = [Int]()
var i:Int
var oneDigitPrimes = [Int]()
var twoDigitPrimes = [Int]()
var threeDigitPrimes = [Int]()
var arrayA = [Int]()
var arrayB = [Int]()

for i in 0...1000 {
    arr.append(i)
}
var flag=0


func checkAnagram(_ arrayA:inout [Int],_ arrayB:inout [Int]) {
    //print("\(arrayA) \(arrayB)")
    var lenA=arrayA.count
    var lenB=arrayB.count
    var storeArrayA=arrayA
    var storeArrayB=arrayB
    
    if lenA==lenB {
        var i:Int
        var j:Int
        var temp2:Int
        
        for i in 0...(lenA-2) {
            for j in i+1...(lenA-1){
                if arrayA[j]<arrayA[i] {
                    temp2=arrayA[j]
                    arrayA[j]=arrayA[i]
                    arrayA[i]=temp2
                }
            }
        }
        
        for i in 0...(lenB-2) {
            for j in i+1...(lenB-1){
                if arrayB[j]<arrayB[i] {
                    temp2=arrayB[j]
                    arrayB[j]=arrayB[i]
                    arrayB[i]=temp2
                }
            }
        }
        
       if arrayA==arrayB {
        print("\(storeArrayA)   \(storeArrayB)")
       }
    }
}


oneDigitPrimes.append(2)
oneDigitPrimes.append(3)

for i in 4...1000 {
    flag = 0
    for j in 2...(i/2) {
        if arr[i]%j == 0 {
            flag=1
        }
    }
    if flag==0 {
        if i/10 == 0 {
            oneDigitPrimes.append(i)
        }
        else if i/100 == 0 {
            twoDigitPrimes.append(i)
        }
        else {
            threeDigitPrimes.append(i)
        }
    }
}
//print("\(twoDigitPrimes)")
print("Anagram pairs are : ")

//print(countTwoDigitPrimes)
func sendTestPairs(_ twoDigitPrimes:inout [Int]) {
    var countTwoDigitPrimes=twoDigitPrimes.count
    var k:Int
    var tempA:Int
    var tempB:Int
    for i in 0...(countTwoDigitPrimes-2) {
        //    var arrayA = [Int]()
        //    var arrayB = [Int]()
        tempA=twoDigitPrimes[i]
        while(tempA>0) {
            arrayA.append((tempA%10))
            tempA=tempA/10
        }
        arrayA.reverse()
        for j in (i+1)...(countTwoDigitPrimes-1) {
            tempB=twoDigitPrimes[j]
            while(tempB>0) {
                arrayB.append((tempB%10))
                tempB=tempB/10
            }
            
            arrayB.reverse()
            checkAnagram(&arrayA , &arrayB)
            
            arrayB=[]
        }
        arrayA=[]
    }
}

sendTestPairs(&twoDigitPrimes)
sendTestPairs(&threeDigitPrimes)

print("The Palindrome prime numbers are:")
for i in 0...(threeDigitPrimes.count-1) {
    if threeDigitPrimes[i]/100 == threeDigitPrimes[i]%10 {
        print(threeDigitPrimes[i])
    }
}
