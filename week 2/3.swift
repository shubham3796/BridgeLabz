
import Foundation

struct Stack {
    fileprivate var array: [Character] = []
    private var top = -1
    mutating func push(value:Character) {
        array.append(value)
        top+=1
    }
    mutating func pop() -> Character {
        top-=1
        return array[top]
    }
    mutating func peep() -> Character {
        return array[top]
    }
    mutating func isEmpty() -> Bool {
        if top == -1 {
            return true
        }
        else {
            return false
        }
    }
}

var stackOfBraces = Stack()
var expression:String
print("Enter the expression")
expression=readLine()!
var flag=0

for i in expression {
    if i==")" {
        let tempCharacter=stackOfBraces.pop()
        if tempCharacter == "(" {
            //
        }
        else {
            print("False")//Unbalanced parentheses
            flag=1
        }
    }
    else if i=="(" {
        stackOfBraces.push(value: i)
    }
}
if stackOfBraces.isEmpty() {
    print("True")//Balanced parentheses
}
else {
    print("False")//Unbalanced parentheses
}

