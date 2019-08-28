
import Foundation

var arrayA = [Int]()

arrayA.append(-1)
arrayA.append(-1)

var i:Int
var j:Int

for i in 2...1000 {
    arrayA.append(1)
}


for i in 2...500 {
    j=2
    while j <= (1000/i) {
        arrayA[i*j]=0
        j+=1
    }
}

var arrayB = [[Int]]()

i=0
while i<=900 {
    arrayB.append( [] )
    for j in 0...99 {
        if arrayA[i+j] == 1 {
            arrayB[i/100].append(i+j)
        }
    }
    i+=100
}
print("Printing the list of primes(Range wise as stored in 2D array")
for i in 0...9 {
    print(arrayB[i])
}

