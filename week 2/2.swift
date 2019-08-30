
import Foundation



//Declaring the Node class
public class Node<T> {
    var value : T
    var next: Node<T>?
    weak var previous: Node<T>?
    init (val: T) {
        self.value=val
    }
}
public class LinkedList<T : Equatable>{
    private var head : Node<T>?
    private var tail : Node<T>?
    public var first:Node<T>{
        return head!
    }
    public var last:Node<T>{
        return tail!
    }
    
    public var printList:String {
        var tempString = ""
        var node = head
        while node != nil {
            tempString += node!.value as! String
            if node!.next != nil {
                
                tempString+=","
            }
            node = node!.next
        }
        tempString += ""
        return tempString
    }//end printList definition
    
    
    public var isEmpty:Bool {
        return head == nil
    }
    
    
    public func appendInAscendingOrder(value: T) {
        print("Appending \(value)")
        print(printList)
        let newNode = Node(val: value )
        if tail==nil {
            print("flag1")//If list is empty, head=tail=nil
            head=newNode
            tail=newNode
            return
        }
        else {
             print("flag2")
            
            var nodePointer = head
            while  ( Int(nodePointer!.value as! String)! < Int(value as! String)! ) {
                 print("flag3")
                if nodePointer!.next == nil {//insertion at last location
                     print("flag4")
                    newNode.previous = tail
                    tail!.next = newNode
                    tail = newNode
                    return
                }
                nodePointer=nodePointer!.next
            }//endWhile
            
            
            if (value as! String) < (head!.value as! String) {//insert at first location when list is not empty
                 print("flag5")
                newNode.next=head
                head!.previous=newNode
                head=newNode
                return
            }
            else {
                nodePointer!.previous!.next=newNode
                newNode.next=nodePointer
            }//end else
             print("flag6")
            nodePointer!.previous!.next=newNode
            newNode.next=nodePointer
            newNode.previous=nodePointer?.previous
            nodePointer!.previous=newNode
        }
        
        
    }
    public func search(value: T) -> Int {
        var node=head
        var count=1
        
        while node!.next != nil && node!.value != value {
            node = node!.next
            count+=1
        }
        if node!.next == nil {
            if node!.value == value {
                return count
            }
            else {
                return -1
            }
        }
        return count
        
    }
    
    public func deleteViaPosition(nodePosition:Int) {
        var node = head
        if nodePosition == 1 {
            head = node!.next
            head!.previous = nil
            return
        }
        
        var count = 0
        while node != nil && count != nodePosition-2 {
            node = node!.next
            count += 1
        }
        node!.next = node!.next!.next
        if node!.next != nil {
            node!.next!.previous = node
        }
    }
    
}




let inputLocation = NSString(string:"/Users/admin/Desktop//BridgeLabz/week 2/textToRead2.txt").expandingTildeInPath
do {
    
    let fileContent = try NSString(contentsOfFile: inputLocation, encoding: String.Encoding.utf8.rawValue)
    print(fileContent)
    
    
    let array = fileContent.components(separatedBy: " ")
    
    let size = array.count-1
    let myFirstList = LinkedList<String>()
    
    var i = 0
    
    while i <= size
    {
        myFirstList.appendInAscendingOrder(value: array[i])
        i = i + 1
    }
    print("The list is :\(myFirstList.printList) ")
    
    
    print("Type the string to be searched")
    let temp=readLine()
    let stringToSearch=String(temp!)
    let stringPosition=myFirstList.search(value: stringToSearch)
    if stringPosition == -1 {
        myFirstList.appendInAscendingOrder(value: stringToSearch)
    }
    else {
        myFirstList.deleteViaPosition(nodePosition: stringPosition)
    }
    print("The list is :    \(myFirstList.printList) ")
    
    
    let fileName = "ouput2.txt"
    var filePath = ""
    
    // Fine documents directory on device
    let dirs : [String] = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true)
    
    if dirs.count > 0 {
        let dir = dirs[0] //documents directory
        filePath = dir.appending("/" + fileName)
        print("Local path where the output file is saved = \(filePath)")
    } else {
        print("Could not find local directory to store file")
        //return
    }
    
    // Set the contents
    let fileContentToWrite = myFirstList.printList
    
    do {
        // Write contents to file
        try fileContentToWrite.write(toFile: filePath, atomically: false, encoding: String.Encoding.utf8)
    }
    catch let error as NSError {
        print("An error took place: \(error)")
    }
    
    
    
    
}
catch let error {
    print(error.localizedDescription)
}



