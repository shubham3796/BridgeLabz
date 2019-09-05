
import Foundation


class DeckOfCards {
    var clubs=[String]()
    var diamonds=[String]()
    var hearts=[String]()
    var spade=[String]()
    
    func addCard(_ value:String) {
        clubs.append(value)
        diamonds.append(value)
        hearts.append(value)
        spade.append(value)
    }
    func initializeDeckOfCards () {
        addCard("NULL")
        addCard("ACE")
        for i in 2...10 {
            addCard("\(i+2)")
        }
        addCard("JACK")
        addCard("QUEEN")
        addCard("KING")
    }
}

struct card{
    var suitNumber:Int
    var cardNumber:Int
    init (){
        suitNumber=0
        cardNumber=0
    }
}

struct player{
    var cardsWithPlayer:[card]
    
    func printCardsWithAPlayer(){
        var printString = ""
        for card in cardsWithPlayer {
            
            
            if card.cardNumber == 1 {
                printString.append("ACE OF ")
            }
            else if card.cardNumber >= 2 && card.cardNumber <= 10{
                 printString.append("\(card.cardNumber) OF ")
            }
            else if card.cardNumber == 11 {
                 printString.append("JACK OF ")
            }
            else if card.cardNumber == 12 {
                 printString.append("QUEEN OF ")
            }
            else {
                printString.append("KING OF ")
            }
            
            if card.suitNumber == 0{
                printString.append("CLUBS")
            }
            else if card.suitNumber == 1{
                printString.append("DIAMONDS")
            }
            else if card.suitNumber == 2{
                printString.append("HEARTS")
            }
            else {
                printString.append("SPADES")
            }
            printString.append(", ")
        }
        print(printString)
        printString = ""
    }
    
}

class DistributeCards {
    var deckOfCards:DeckOfCards
    var arrayOfCards = [[Bool]]()
    var arrayOfPlayers = [player]()

    init() {
        self.deckOfCards=DeckOfCards()
        deckOfCards.initializeDeckOfCards()
        for suitNumber in 0...3{
            arrayOfCards.append([])
            for cardNumber in 0...13{
                arrayOfCards[suitNumber].append(false)//false indicates that card is not yet distributed
            }
        }
        arrayOfCards[0][0]=true
    }
    
    func shuffleAndDistributeCards() {
        

        for i in 0...8 {
            var temporaryCard=card()
            var temporaryCardsWithPlayer=[card]()
            temporaryCard.suitNumber=0
            temporaryCard.cardNumber=0
            while(arrayOfCards[temporaryCard.suitNumber][temporaryCard.cardNumber] == true) {
            temporaryCard.suitNumber=Int.random(in: 0...3)
            temporaryCard.cardNumber=Int.random(in: 1...13)
            }
            arrayOfPlayers.append(player(cardsWithPlayer: temporaryCardsWithPlayer))
            arrayOfPlayers.append(player(cardsWithPlayer: temporaryCardsWithPlayer))
            arrayOfPlayers.append(player(cardsWithPlayer: temporaryCardsWithPlayer))
           arrayOfPlayers.append(player(cardsWithPlayer: temporaryCardsWithPlayer))
            
            
            arrayOfPlayers[i%4].cardsWithPlayer.append(temporaryCard)
            arrayOfCards[temporaryCard.suitNumber][temporaryCard.cardNumber]=true
        }
    }
    
    func printCardsDistributed() {
        for i in 0...3 {
            print("Cards with player \(i+1) : ")
            arrayOfPlayers[i].printCardsWithAPlayer()
            print("")
            print("")
        }
       
    }
    
}

var object = DistributeCards()
object.shuffleAndDistributeCards()
object.printCardsDistributed()
