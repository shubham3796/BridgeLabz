import Foundation

print("Enter stake")
var temp = readLine()
var stake = Int(temp!)

print("Enter Goal")
var temp1 = readLine()
var goal = Int(temp1!)

print("Enter Number of times you want to bet")
var temp2 = readLine()
var totalGames = Int(temp2!)

var noWins = 0
var noLoss = 0
var gameNum=1
//var stake=stake
var chance:Float
var fair=1

while ((gameNum <= totalGames!) && (stake! < goal!) && (stake!>0) ){
    
    print("GAME NUMBER \(gameNum) :")

    chance = Float.random(in: 0...1) //Probability of winning
    if chance<0.5 {
        stake! -= fair
        noLoss += 1
    }
    else {
        stake! += fair
        noWins += 1
    }
    gameNum += 1
}

print("Number of wins is \(noWins) ")

var percentWin = Float(100) * (Float(noWins)/(Float(noWins) + Float(noLoss)))
var percentLoss = Float(100) * (Float(noLoss)/(Float(noWins) + Float(noLoss)))

print("Percentage of wins is \(percentWin) ")
print("Percentage of losses is \(percentLoss) ")
