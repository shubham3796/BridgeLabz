import Foundation

print("Enter total numbers")
var n=readLine()
var N=Int(n!)

var arr=[Int]()
var i:Int
var numbersNeeded=1
print("Enter \(N!) distict numbers")
for i in 1...N!{
    let temp=readLine()
    let temp2=Int(temp!)
    arr.append(temp2!)
}
//var k:Int
//for k in arr{
//    print(k)
//}
class Processing{
    
    static func randGen()->Int{
        var randNum = Int.random(in: 1...100)
        return randNum
    }
    
     static func check()->Void{
        var flag=1
        while flag==1{
            flag=0
            var a=randGen()
            
            var j:Int
            for j in arr{
                if j==a{
                    if flag==0{
                        numbersNeeded+=1
                    }//endif
                    flag=1
                }//endif
            }//endfor
        }//endwhile
        print("Number of random numbers needed is \(numbersNeeded)")
    }//end check()
}

Processing.check()
