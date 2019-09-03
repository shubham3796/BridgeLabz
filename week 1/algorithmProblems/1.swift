import Foundation

var stringA=[Character]()
var stringB=[Character]()
stringA.append(" ")
stringB.append(" ")

print("Enter string 1:")
var temporaryVariable=readLine()
stringA=temp!+stringA

print("Enter string 2:")
 temporaryVariable=readLine()
stringB=temp!+stringB


var lengthA=stringA.count
var lengthB=stringB.count


if lengthA==lengthB {
    var iteratorA:Int
    var iteratorB:Int
    var temporaryVariable2:Character
    
 //Sorting string A
    for iteratorA in 0...(lengthA-2) {
        for iteratorB in iteratorA+1...(lengthA-1){
            if stringA[iteratorB]<stringA[iteratorA] {//Swap the two
                temporaryVariable2=stringA[iteratorB]
                stringA[iteratorB]=stringA[iteratorA]
                stringA[iteratorA]=temporaryVariable2
            }
        }
    }
    //Sorting string B 
    for iteratorA in 0...(lengthB-2) {
        for j in iteratorA+1...(lengthB-1){
            if stringA[iteratorB]<stringA[iteratorA] {//Swap the two
                temporaryVariable2=stringA[iteratorB]
                stringA[iteratorB]=stringA[iteratorA]
                stringA[iteratorA]=temporaryVariable2
            }
        }
    }
    
    if stringA==stringB {
        print("Anagram")
    }
    else{
        print("Not Anagram")
    }
}
else {
    print("Not Anagram")
}
