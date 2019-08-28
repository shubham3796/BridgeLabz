
import Foundation

var constant = 100000007

func moduloAdd(valA:Int,valB:Int)->Int {
    let tempA = valA % constant
    let tempB = valB % constant
    return ((tempA+tempB)%constant)
}

func moduloMultiply(valA:Int,valB:Int)->Int {
    return (((valA % constant) * (valB % constant))%constant)
}

func moduloInverse(value:Int) -> Int {
    let val=value%constant
    var inverseVal:Int
    for inverseVal in 1...(constant-1) {
        if (val*inverseVal)%constant == 1 {
            return inverseVal
        }
    }
    return 1
}


func moduloDivide(valA:Int,valB:Int)->Int {
    let tempA = valA % constant
    let bInverse = moduloInverse(value: valB)
    let tempC = bInverse % constant
    return (tempA*tempC)%constant
}

var temp=readLine()
var noOfTestCases=Int(temp!)//input number of test cases
var i=0
var numberOfNodes=[Int]()
var numberOfTrees=[Int]()

//var count=0
for i in 1...noOfTestCases! {
    temp=readLine()
    numberOfNodes.append(Int(temp!)!)
    //count+=1
}




for i in 1...noOfTestCases! {
    if numberOfNodes[i-1] <= 10 {
            var factorialArray=[Int]()
        
            factorialArray.append(1)
            factorialArray.append(1)
            for j in 2...(2*numberOfNodes[i-1]) {
                factorialArray.append(1)
                factorialArray[j]=(factorialArray[j-1]*j)
            }
            var temporary = ( (factorialArray[2*numberOfNodes[i-1]] ) / ( (  factorialArray[numberOfNodes[i-1]]) * ( factorialArray[1 + numberOfNodes[i-1]] ) ) )
            numberOfTrees.append(temporary)
    }
    else {
        var factorialArray=[Int]()

        factorialArray.append(1)
        factorialArray.append(1)
        for j in 2...(2*numberOfNodes[i-1]) {
            factorialArray.append(1)
            factorialArray[j]=moduloMultiply(valA: factorialArray[j],valB: j)
        }
        let temporaryA = moduloMultiply(valA: factorialArray[numberOfNodes[i-1]] , valB: factorialArray[1 + numberOfNodes[i-1]] )
        var temporary = moduloDivide( valA: factorialArray[2*numberOfNodes[i-1]] , valB: temporaryA)
        numberOfTrees.append(temporary)
    }
}

for i in 1...noOfTestCases! {
    print(numberOfTrees[i-1]%constant)
}


