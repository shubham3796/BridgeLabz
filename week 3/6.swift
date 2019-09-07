
import Foundation

class NodeCompanyShares {
    var stockSymbol:String
    var stockValue:Float
    var dateTime:String
    var next : NodeCompanyShares?
    weak var prev : NodeCompanyShares?
    init(_ stockSymbol:String,_ stockValue:Float,_ dateTime:String) {
        self.stockSymbol=stockSymbol
        self.stockValue=stockValue
        self.dateTime=dateTime
        self.next=nil
    }
    
}

class linkedListOfShares {
    private var head:NodeCompanyShares?
    public var first:NodeCompanyShares {
        return head!
    }
    private var tail:NodeCompanyShares?
    public var last:NodeCompanyShares {
        return tail!
    }
    
    public func append(_ stockSymbol:String,_ stockValue:Float,_ dateTime:String) {
        let newNode=NodeCompanyShares(stockSymbol,stockValue,dateTime)
        if head==nil {
            head = newNode
            tail=newNode
            return
        }
        else {
            
            tail!.next=newNode
            tail=newNode
            tail?.next=nil
            
        }
    }
}

public class StockAccount {
    var listOfShares : linkedListOfShares
    var fileName:String
    var shareValue:Float
    
    init(_ filename:String) {//create a new account from file
        self.fileName=filename
        self.listOfShares = linkedListOfShares()
        self.shareValue = 1.50 //Constant for a company
        let inputLocation = NSString(string:"/Users/admin/Documents/week3prob5.txt").expandingTildeInPath
        do {
            let fileContent = try NSString(contentsOfFile: inputLocation, encoding: String.Encoding.utf8.rawValue)
            var stock:[String]
            stock = fileContent.components(separatedBy: "\n")
            let numberOfStocks = stock.count
            var temporaryArrayOfStrings:[String]
            var i = 0
            
            while i<numberOfStocks && stock[i] != "" {
                temporaryArrayOfStrings = stock[i].components(separatedBy: " ")
                print(temporaryArrayOfStrings)
                let stockSymbol = temporaryArrayOfStrings[0]
                let stockValue = Float(temporaryArrayOfStrings[1])!
                var dateTime = ""
                dateTime +=  temporaryArrayOfStrings[2]
                dateTime += " "
                dateTime += temporaryArrayOfStrings[3]
                listOfShares.append(stockSymbol,stockValue,dateTime)
                i+=1
            }
            
        }
        catch let error {
            print(error.localizedDescription)
        }
        
    }
    
    
    func valueOf() -> Double {
        var totalValueOfAccount = 0.00
        var temporaryPointer = listOfShares.first
        while temporaryPointer.next != nil {
            totalValueOfAccount += Double(temporaryPointer.stockValue)
            temporaryPointer = temporaryPointer.next!
        }
        totalValueOfAccount += Double(temporaryPointer.stockValue)
        return totalValueOfAccount
    }
    
    
    func buy(_ amount:Int,_ symbol:String) {
        var temporaryPointer = listOfShares.first
        while temporaryPointer.next != nil {
            if temporaryPointer.stockSymbol == symbol && temporaryPointer.stockValue>=0 {//company shares are available
                temporaryPointer.stockValue += Float(amount)
                return
            }
            temporaryPointer = temporaryPointer.next!
        }
        if temporaryPointer.stockSymbol == symbol && temporaryPointer.stockValue>=0 {//company shares are available
            temporaryPointer.stockValue += Float(amount)
            return
        }
        let currentHour = Calendar.current.component(.hour,from:Date())
        let currentMinute = Calendar.current.component(.minute,from:Date())
        let currentDate = Calendar.current.component(.day,from:Date())
        let currentMonth = Calendar.current.component(.month,from:Date())
        let currentYear = Calendar.current.component(.year,from:Date())
        let dateTime = "\(currentDate)/\(currentMonth)/\(currentYear) \(currentHour):\(currentMinute)"
        listOfShares.append(symbol,Float(amount),dateTime)
    }
    
    
    func sell(_ amount:Int,_ symbol:String) {
        var temporaryPointer = listOfShares.first
        while temporaryPointer.next != nil {
            if temporaryPointer.stockSymbol == symbol && temporaryPointer.stockValue>0 {//company shares are available
                if temporaryPointer.stockValue >= Float(amount) {
                    temporaryPointer.stockValue -= Float(amount)
                    return
                }
                else {
                    temporaryPointer.stockValue = 0.00
                    return
                }
            }
            temporaryPointer = temporaryPointer.next!
        }
        if temporaryPointer.stockSymbol == symbol && temporaryPointer.stockValue>0 {//company shares are available
            if temporaryPointer.stockValue >= Float(amount) {
                temporaryPointer.stockValue -= Float(amount)
                return
            }
            else {
                temporaryPointer.stockValue = 0.00
                return
            }
        }
        print("Coundn't sell \(symbol) . Not available sufficiently")
    }
    
    
    func save(_ fileName:String) {//save contents to this file
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
        var fileContentToWrite = ""
        var temporaryPointer=listOfShares.first
        while temporaryPointer.next != nil {
            // Set the contents
            fileContentToWrite += "\(temporaryPointer.stockSymbol) \(temporaryPointer.stockValue) \(temporaryPointer.dateTime)\n"
            temporaryPointer = temporaryPointer.next!
        }
        fileContentToWrite += "\(temporaryPointer.stockSymbol) \(temporaryPointer.stockValue) \(temporaryPointer.dateTime)\n"
        
        do {
            // Write contents to file
            try fileContentToWrite.write(toFile: filePath, atomically: false, encoding: String.Encoding.utf8)
        }
        catch let error as NSError {
            print("An error took place: \(error)")
        }
        
    }
    
    
    func printReport() {
        
        print(".....REPORT.....")
        var temporaryPointer=listOfShares.first
        while temporaryPointer.next != nil {
            print("\(temporaryPointer.stockSymbol) \(temporaryPointer.stockValue) \(temporaryPointer.dateTime)")
            temporaryPointer = temporaryPointer.next!
        }
        print("\(temporaryPointer.stockSymbol) \(temporaryPointer.stockValue) \(temporaryPointer.dateTime)")
    }
    
    
}

var stockAccount1=StockAccount("week3prob5.txt")
stockAccount1.buy(8,"c")
stockAccount1.buy(6,"b")
stockAccount1.sell(2,"c")
stockAccount1.sell(2,"a")
stockAccount1.buy(10,"d")
stockAccount1.save("week3prob5.txt")
stockAccount1.printReport()
