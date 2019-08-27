
import Foundation

var array=[1,2,5,10,50,100,500,1000]//Array of available note denominations

func getDenomination(_ arr:inout [Int],_ change:inout Int,_ numNotes:inout Int) -> Void{
    if change==0 {
        print("Minimum number of notes needed = \(numNotes)")
        return
    }
    //print(change)
    var i=7
    while i>0 && change<=arr[i] {
        i-=1
    }
    var temp:Int
    
    temp=change/arr[i]
    change-=temp*arr[i]
    numNotes+=temp
    var j:Int
    
    if temp>0 {
    for j in 0...(temp-1) {
        print(arr[i])
    }
    }
    getDenomination(&arr,&change,&numNotes)
}

print("Enter the total amount whose you need")
var tempA=readLine()
var change=Int(tempA!)
var numNotes=0

getDenomination(&array,&change!,&numNotes)


