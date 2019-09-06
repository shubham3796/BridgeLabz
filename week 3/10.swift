
import Foundation


struct card{
    var suitNumber:Int
    var cardNumber:Int
    init (){
        suitNumber=0
        cardNumber=0
    }
}



class Node {
    var card:card
    var next:Node?
    init(_ card:card){
        self.card=card
        self.next=nil
    }
}



struct linkedList{
    
    private var head:Node?
    public var first: Node {
        return head!
    }
    
    private var tail:Node?
    public var last: Node {
        return tail!
    }
    
    mutating func insertCardInList(_ card:card){//insert at end
        let node=Node(card) //create a new node
        if head == nil {
            head=node
            tail=node
        }
        else {
            tail!.next=node
            tail=node
        }
    }
    
    func lengthOfListOfCards()->Int{
        var count=0
        var temporaryPointer=head
        while temporaryPointer!.next != nil{
            count += 1
            temporaryPointer = temporaryPointer?.next!
        }
        return count+1
    }
    
    func printList(){
        var temporaryPointer=head
        var cardNumber=[Int]()
        var suitNumber=[Int]()
        var count=0
        var printString=""
        while temporaryPointer!.next != nil{
            cardNumber.append((temporaryPointer?.card.cardNumber)!)
            suitNumber.append((temporaryPointer?.card.suitNumber)!)
            temporaryPointer = temporaryPointer?.next!
            count+=1
        }
        cardNumber.append((temporaryPointer?.card.cardNumber)!)
        suitNumber.append((temporaryPointer?.card.suitNumber)!)
        for i in 0...count {
            if cardNumber[i] == 1 {
                printString.append("ACE OF ")
            }
            else if cardNumber[i] >= 2 && cardNumber[i] <= 10{
                printString.append("\(cardNumber[i]) OF ")
            }
            else if cardNumber[i] == 11 {
                printString.append("JACK OF ")
            }
            else if cardNumber[i] == 12 {
                printString.append("QUEEN OF ")
            }
            else {
                printString.append("KING OF ")
            }
            if suitNumber[i] == 0{
                printString.append("CLUBS")
            }
            else if suitNumber[i] == 1{
                printString.append("DIAMONDS")
            }
            else if suitNumber[i] == 2{
                printString.append("HEARTS")
            }
            else {
                printString.append("SPADES")
            }
            printString.append(", ")
        }//end for
        print(printString)
        printString = ""
    }//end func printList()
    
}



struct player{
    var cardsWithPlayer=[card]()
    var listOfCardsWithPlayer = linkedList()
    mutating func createListOfCards() {
        for card in cardsWithPlayer {
            listOfCardsWithPlayer.insertCardInList(card)
        }
    }
    
    mutating func sortCardsWithAPlayer() {
        createListOfCards()
        var temporaryPointerA=listOfCardsWithPlayer.first
        var temporaryPointerB=listOfCardsWithPlayer.first
        let numberOfCards = listOfCardsWithPlayer.lengthOfListOfCards()
        var stopFlag1=false
        if numberOfCards == 0 || numberOfCards == 1 {
            return
        }
        while temporaryPointerA.next != nil {
            temporaryPointerB=temporaryPointerA.next!
            stopFlag1 = false
            while stopFlag1 == false {
                if temporaryPointerA.card.cardNumber > temporaryPointerB.card.cardNumber {
                    
                    var temporaryCard:card
                    temporaryCard = temporaryPointerA.card
                    temporaryPointerA.card = temporaryPointerB.card
                    temporaryPointerB.card = temporaryCard
                    
                }
                if temporaryPointerB.next == nil {
                    stopFlag1=true
                }
                else {
                    temporaryPointerB = temporaryPointerB.next!
                }
                
            }
            temporaryPointerA = temporaryPointerA.next!
        }
        listOfCardsWithPlayer.printList()
    }//end func sortCardsWithAPlayer
}



class InitializeDeckAndDistributeCards {
    var arrayOfCards = [[Bool]]()
    var arrayOfPlayers = [player]()
    
    init() {
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
            var temporaryLinkedList:linkedList
            temporaryCard.suitNumber=0
            temporaryCard.cardNumber=0
            while(arrayOfCards[temporaryCard.suitNumber][temporaryCard.cardNumber] == true) {
                temporaryCard.suitNumber=Int.random(in: 0...3)
                temporaryCard.cardNumber=Int.random(in: 1...13)
            }
            arrayOfPlayers.append(player())
            arrayOfPlayers.append(player())
            arrayOfPlayers.append(player())
            arrayOfPlayers.append(player())
            arrayOfPlayers[i%4].cardsWithPlayer.append(temporaryCard)
            arrayOfCards[temporaryCard.suitNumber][temporaryCard.cardNumber]=true
        }
    }
    
    func printCardsDistributed() {
        for i in 0...3 {
            print("Cards with player \(i+1) : ")
            arrayOfPlayers[i].sortCardsWithAPlayer()
            print("")
            print("")
        }
    }
    
}

var object = InitializeDeckAndDistributeCards()
object.shuffleAndDistributeCards()
object.printCardsDistributed()
