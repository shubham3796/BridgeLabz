
import Foundation

class Node {
     var value:Character
     var next:Node?
    init(value:Character) {
        self.value=value
    }
}

class DeQueue {
    private var first:Node?
    private var last:Node?
    public var head:Node?{
        return first
    }
    public var tail:Node?{
        return last
    }
    private var size=0
    func addFront(value:Character) {
        let newNode = Node(value: value)
        
        if first == nil && last == nil {//empty deque
            first = newNode
            last = newNode
            size=1
        }
        else {
            newNode.next=first
            first=newNode
            size+=1
        }
    }
    
    func addRear(value:Character) {
        let newNode = Node(value: value)
        
        if first == nil && last == nil {//empty deque
            first = newNode
            last = newNode
            size=1
        }
        else {
            last!.next=newNode
            last=newNode
            size+=1
        }
    }
    
    func removeFront() -> Character{
        var removedChar:Character
        if first==nil {//empty list
            print("EmptyList")
            return Character("")
        }
        else {
            removedChar=first!.value
            first=first!.next
            size-=1
        }
        return removedChar
    }
    
    func removeRear()->Character{
        var removedChar:Character
        if last==nil {//Empty List
            print("EmptyList")
            return Character("")
        }
        else if last!.next == nil {//only one node present in the list
            removedChar=last!.value
            first=nil
            last=nil
            size=0
        }
        else {
            removedChar=last!.value
            var temp=first
            var count=0
            while count > size-2 {
                temp=temp!.next
                count+=1
            }
            last=temp
            last!.next=nil
        }
        return removedChar
    }
    
    func isEmpty()->Bool{
    if first==nil && last==nil {
    return true
    }
    else {
    return false
    }
    }
    
}

var myQueue=DeQueue()
print("Enter the string")
var givenString=readLine()
for i in givenString! {
    myQueue.addRear(value: i)
}

var flag=0
var flagB=0
while flag==0 && flagB==0 {
    let characterA=myQueue.removeFront()
    let characterB=myQueue.removeRear()
    if characterA != characterB {
        flag=1
        if myQueue.isEmpty() {
            flag=1
        }
    }
    else if myQueue.isEmpty() {
        flagB=1
    }
}
if flag==1 {
    print("False")
}
else {
    print("True")
}
