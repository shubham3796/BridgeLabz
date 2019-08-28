import Foundation

func checkAnagram(_ arrayA:inout [Int],_ arrayB:inout [Int])->Bool {
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
            return true
        }
    }
    return false
}


var arrayA = [Int]() //array of primes in range 0...1000
var isAnagramA = [Int]()//indicates whether a number is anagram or not

arrayA.append(-1)
arrayA.append(-1)
isAnagramA.append(0)
isAnagramA.append(0)
var i:Int
var j:Int

for i in 2...1000 {
    arrayA.append(1)
    isAnagramA.append(0)
}
for i in 2...9 {
     isAnagramA[i]=1
}

for i in 2...500 {
    j=2
    while j <= (1000/i) {
        arrayA[i*j]=0
        j+=1
    }
}



for i in 0...998 {
    var anagramArrayA = [Int]()
   
    if arrayA[i]==1 && i>10 {
        var tempA=i
        while(tempA>0) {
            anagramArrayA.append((tempA%10))
            tempA=tempA/10
        }
       // anagramArrayA.reverse()
        for j in (i+1)...999 {
             var anagramArrayB = [Int]()
            if arrayA[j]==1 && j>10{
                var tempB=j
                while(tempB>0) {
                    anagramArrayB.append((tempB%10))
                    tempB=tempB/10
                }
                var result = checkAnagram(&anagramArrayA,&anagramArrayB)
                if result {
                    isAnagramA[i]=1
                    isAnagramA[j]=1
                }
            }
        }
    }
    
}


var arrayB = [[Int]]()//2D array containing anagram primes

i=0
while i<=900 {
    arrayB.append( [] )
    for j in 0...99 {
        if arrayA[i+j] == 1 && isAnagramA[i+j]==1 {//if the number is prime and anagram
            arrayB[i/100].append(i+j)
        }
    }
    i+=100
}

print("Printing the list of primes which are anagrams(Range wise as stored in 2D array")
for i in 0...9 {
    print(arrayB[i])
}


print("")
print("")
print("")
print("")
print("")


var arrayC = [[Int]]()//2D array containing all primes

i=0
while i<=900 {
    arrayC.append( [] )
    for j in 0...99 {
        if arrayA[i+j] == 1 {//if the number is prime
            arrayC[i/100].append(i+j)
        }
    }
    i+=100
}
print("Printing the list of primes(Range wise as stored in 2D array")
for i in 0...9 {
    print(arrayC[i])
}
