
import Foundation

struct Stack {
    fileprivate var array: [Character] = []
    private var top = -1
    mutating func push(value:Character) {
        array.append(value)
        top+=1
    }
    mutating func pop() -> Character {
        if top == -1 {
            return "@"
        }
        else {
            top = -1
            return array[top+1]
        }
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

for character in expression {
    if character==")" {
        let temporaryCharacter=stackOfBraces.pop()
        if temporaryCharacter != "(" {
            print("False")//Unbalanced parentheses
            exit(0)
        }
    }
    else if character=="(" {
        stackOfBraces.push(value: character)
    }
}
if stackOfBraces.isEmpty() {
    print("True")//Balanced parentheses
}
else {
    print("False")//Unbalanced parentheses
}

