

import Foundation
class Node {
    var action:Int
    var amount:Int
    var next:Node?
    init(action:Int,amount:Int) {
        self.action=action
        self.amount=amount
    }
}

class LinkedList {
    private var head:Node?
    public var first:Node?{
        return head
    }
    private var tail:Node?
    /*public var last:Node?{
        return tail
    }*/
    private var balance=0
    //private var flagUnbalanced=0
    
    func performAction(action:Int,amount:Int)->Int {
        if action==0 {//Deposit
            balance += amount
        }
        else if action==1{//withdraw
            if balance<amount {//UNBALANCED OPERATION
                return 0
            }
            else {
                balance -= amount
            }
        }
        return 1
    }
    func push(action:Int,amount:Int)->Int {
        let newNode = Node(action: action,amount: amount)
        if head==nil {
            head=newNode
            tail=newNode
            if action==0 {
                return 0
            }
            else {//UNBALANCED OPERATION. CAN'T WITHDRAW FROM ZERO BALANCE
                return 1
            }
        }
        else {
            tail!.next=newNode
            tail=tail!.next
        }
        let isUnbalanced = performAction(action: action,amount: amount)
        if isUnbalanced==1 {
            return 0//unbalanced operation
        }
        else {
            return 1
        }
    }
}

var choice=0//default
var queue=LinkedList()
var flagBalanced=0//Indicates balanced transactions
while choice==0 || choice==1 {
    print("Type 0 to deposit, Type 1 to withdraw, Type 2 to exit")
    var temp=readLine()
    choice=Int(temp!)!
    if choice==0 {
        print("Enter the amount to be deposited")
        temp=readLine()
        let amount = Int(temp!)
        flagBalanced=queue.push(action: choice,amount: amount!)
    }
    else if choice==1 {
        print("Enter the amount to be withdrawn")
        temp=readLine()
        let amount = Int(temp!)
        flagBalanced=queue.push(action: choice,amount: amount!)
    }
    
}

if flagBalanced == 0{
    print("True")
}
else {
    print("False")
}

