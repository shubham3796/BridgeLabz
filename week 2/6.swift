import Foundation

var intArray = [Int]()
var size=0
let inputLocation = NSString(string:"/Users/admin/Documents/textToRead6.txt").expandingTildeInPath //INPUT A LIST OF INTEGERS AS CHARACTERS ONE BY ONE. CAN BE CONVERTED TO INETEGER AGAIN
do {
    
    let fileContent = try NSString(contentsOfFile: inputLocation, encoding: String.Encoding.utf8.rawValue)
    print(fileContent)
    
    
    let array = fileContent.components(separatedBy: " ")
    print("array=\(array)")
    
    size = array.count
    var i:Int
    
    for i in 0...(size-1) {
        intArray.append(Int(array[i])!)
    }
}
catch let error {
    print(error.localizedDescription)
}
print(intArray)


var twoDimensionArray = Array(repeating:[Int](),count:(size+1))//Declare 2D array

for i in 0..<size {//Add the numbers to 2D array
    let number=intArray[i]
    let remainder=number%(size+1)
    twoDimensionArray[remainder].append(number)
}
//Display the 2D array
for i in 0...size {
    print(twoDimensionArray[i])
}
//OUTPUT THE 2D INTEGER ARRAY IN A SINGLE LINE
var exitFlag=0
while exitFlag != -1 {
    //search the number
    print("Enter the number to be searched. Type -1 to exit")
    var temp=readLine()
    let number=Int(temp!)
    if number == -1 {
        exitFlag = -1
    }
    else {
        let remainder=number!%(size+1)
        var numFound=false
        let sizeOfList = twoDimensionArray[remainder].count
        var j=0
        while j<sizeOfList {
            if twoDimensionArray[remainder][j]==number {//number found
                twoDimensionArray[remainder][j]=0 //remove the number
                numFound=true
            }
            j+=1
        }
        if !numFound {
            twoDimensionArray[remainder].append(number!)//Number not found. Add it
        }
        
        //Display the 2D array
        for i in 0...size {
            print(twoDimensionArray[i])
        }
        var oneDimensionArray = [Int]()
        for i in 0...size {
            for j in 0..<twoDimensionArray[i].count{
                if twoDimensionArray[i][j] != 0 {
                    oneDimensionArray.append(twoDimensionArray[i][j])
                }
            }
        }
        
        var s = oneDimensionArray.map { String($0) }.joined(separator: " ")
        
        let saveToPath = "/Users/admin/Documents/textToRead6.txt"
        do {
            try s.write(toFile: saveToPath, atomically: true, encoding: String.Encoding.utf8)
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
}



