
import Foundation

var flag=0
var filledComp=0
var filledPlayer=0
var arr = [[Character]]()//Let this be the tic tac toe mattrix
var a=0
var b=0
for a in 0...2 {
    arr.append([])
    for b in 0...2 {
        arr[a].append(" ")    }
}

func displayMattrix(_ arr:inout [[Character]]) {
    var i:Int
    for i in 0...2 {
        print(arr[i])
    }
    print("")
    print("")
}

func check(_ arr:inout [[Character]],_ flag:inout Int )->Int {
    //check all rows
    for i in 0...2 {
        if arr[i][0]==arr[i][1] && arr[i][1]==arr[i][2] {
            var ch=arr[i][0]
            if ch=="X" {
                print("You won!")
                flag=1
            }
            else if ch=="O" {
                print("Computer won!")
                flag=1
            }
        }
    }
    //check all columns
    for j in 0...2 {
        if arr[0][j]==arr[1][j] && arr[1][j]==arr[2][j] {
            var ch=arr[1][j]
            if ch=="X" {
                print("You won!")
                flag=1
            }
            else if ch=="O" {
                print("Computer won!")
                flag=1
            }
        }
    }
    //check both diagonals
    if arr[0][0]==arr[1][1] &&  arr[1][1]==arr[2][2] {
        var ch=arr[1][1]
        if ch=="X" {
            print("You won!")
            flag=1
        }
        else if ch=="O" {
            print("Computer won!")
            flag=1
        }
    }
    return(flag)
    
    if arr[2][0]==arr[1][1] &&  arr[1][1]==arr[0][2] {
        var ch=arr[1][1]
        if ch=="X" {
            print("You won!")
            flag=1
        }
        else if ch=="O" {
            print("Computer won!")
            flag=1
        }
    }
    return(flag)
}

while flag==0 {
    
    
    while filledComp==0 {
        //rows and column chosen by computer
        var row=Int.random(in: 0...2)
        var column=Int.random(in: 0...2)
        
        if arr[row][column]==" " {
            arr[row][column]="O"
            filledComp=1//Fill the computer mark in its place of choice
            displayMattrix(&arr)
            if(check(&arr,&flag)==1) {//check if compuer won or if it was a draw
                flag=1
            }
        }
    }
    filledComp=0
    
    while filledPlayer==0 {
        //rows and column chosen by player
        var temp=readLine()
        var row=Int(temp!)
        var tempA=readLine()
        var column=Int(tempA!)
        
        if arr[row!][column!]==" " {
            arr[row!][column!]="X"
            filledPlayer=1//Fill the player mark in his place of choice
            displayMattrix(&arr)
            if(check(&arr,&flag)==1) {//check if player won or if it was a draw
                flag=1
            }
        }
    }
    filledPlayer=0
}

