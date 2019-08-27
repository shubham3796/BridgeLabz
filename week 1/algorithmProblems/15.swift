class BinaryConvertor {
    
    static func toBinary(_ number: inout Int) -> Void {//All functions in global scope are implicitly static in Swift 5
        var array=[Int]()
        var i:Int
        var k=31
        for i in 0...31 {
            array.append(0)
        }
        while number>0 {
            array[k]=number%2
            k-=1
            number=number/2
        }
        //array.reverse()
        
        //Display Binary form
            print(array)
}
    
}

print("Enter the number")
var temp=readLine()
var number=Int(temp!)
//let bObject=BinaryConvertor()
BinaryConvertor.toBinary(&number!)
