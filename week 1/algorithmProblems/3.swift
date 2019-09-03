
import Foundation

var array = [Int]()
var number:Int
var oneDigitPrimes = [Int]()//Array containing all one digit prime numbers
var twoDigitPrimes = [Int]()
var threeDigitPrimes = [Int]()
var arrayA = [Int]()
var arrayB = [Int]()
var flag=0

//Check whether the two numbers represented as array of integers are anagram pairs or not
func checkAnagram(_ arrayA:inout [Int],_ arrayB:inout [Int]) {
    //print("\(arrayA) \(arrayB)")
    var lengthA=arrayA.count
    var lengthB=arrayB.count
    var storeArrayA=arrayA
    var storeArrayB=arrayB
    
    if lengthA==lengthB {
    var iteratorA:Int
    var iteratorB:Int
    var temporaryVariable2:Int
    
 //Sorting array A
    for iteratorA in 0...(lengthA-2) {
        for iteratorB in iteratorA+1...(lengthA-1){
            if stringA[iteratorB]<stringA[iteratorA] {//Swap the two
                temporaryVariable2=stringA[iteratorB]
                stringA[iteratorB]=stringA[iteratorA]
                stringA[iteratorA]=temporaryVariable2
            }
        }
    }
    //Sorting array B 
    for iteratorA in 0...(lengthB-2) {
        for iteratorB in iteratorA+1...(lengthB-1){
            if stringA[iteratorB]<stringA[iteratorA] {//Swap the two
                temporaryVariable2=stringA[iteratorB]
                stringA[iteratorB]=stringA[iteratorA]
                stringA[iteratorA]=temporaryVariable2
            }
        }
    }
        
       if arrayA==arrayB {
        print("\(storeArrayA)   \(storeArrayB)")
       }
    }
}

//Mkae distict pairs of primes and send to another method to test whether they are anagram pair or not.
func sendTestPairs(_ twoDigitPrimes:inout [Int]) {
    var countTwoDigitPrimes=twoDigitPrimes.count
    var twoDigitPrimeNumber:Int
    
    //Make an array storing the individual digits of the first two digit prime number.
    for iterator in 0...(countTwoDigitPrimes-2) {  
        twoDigitPrimeNumbertwoDigitPrimes[iterator]
        while(twoDigitPrimeNumber>0) {
            arrayA.append((twoDigitPrimeNumber%10))
            twoDigitPrimeNumber=twoDigitPrimeNumber/10
        }
        arrayA.reverse()
        
        //Make an array storing the individual digits of the second two digit prime number.
        for iterator2 in (iterator+1)...(countTwoDigitPrimes-1) {
            twoDigitPrimeNumber=twoDigitPrimes[iterator2]
            while(twoDigitPrimeNumber>0) {
                arrayB.append((twoDigitPrimeNumber%10))
                twoDigitPrimeNumber=twoDigitPrimeNumber/10
            }
            arrayB.reverse()
            
            
            checkAnagram(&arrayA , &arrayB)
            
            arrayB=[]
        }
        arrayA=[]
    }
}


for number in 0...1000 {
    array.append(iterator)
}

oneDigitPrimes.append(2)
oneDigitPrimes.append(3)

for number in 4...1000 {
    flag = 0
    for divisor in 2...(number/2) {
        if array[number]%divisor == 0 {
            flag=1
        }
    }
    if flag==0 {
        if number/10 == 0 {
            oneDigitPrimes.append(number)
        }
        else if number/100 == 0 {
            twoDigitPrimes.append(number)
        }
        else {
            threeDigitPrimes.append(number)
        }
    }
}


print("The anagram primes are:")
sendTestPairs(&twoDigitPrimes)
sendTestPairs(&threeDigitPrimes)

print("The Palindrome prime numbers are:")
for iterator in 0...(threeDigitPrimes.count-1) {
    if threeDigitPrimes[iterator]/100 == threeDigitPrimes[iterator]%10 {
        print(threeDigitPrimes[iterator])
    }
}
