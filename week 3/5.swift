
import Foundation

class CompanyShares{
    var stockSymbol:String
    var stockValue:Float
    var dateTime:String
    init(stockSymbol:String,stockValue:Float,dateTime:String) {
        self.stockSymbol=stockSymbol
        self.stockValue=stockValue
        self.dateTime=dateTime
    }
}

public class StockAccount {
    var listOfShares : [CompanyShares]
    var fileName:String
    var shareValue:Float
    
    init(_ filename:String) {//create a new account from file
        self.fileName=filename
        self.listOfShares = []
        self.shareValue = 1.50 //Constant for a company
        let inputLocation = NSString(string:"/Users/admin/Documents/week3prob5.txt").expandingTildeInPath
        do {
            let fileContent = try NSString(contentsOfFile: inputLocation, encoding: String.Encoding.utf8.rawValue)
            //print(fileContent)
            var stock:[String]
            stock = fileContent.components(separatedBy: "\n")
            let numberOfStocks = stock.count
            print(numberOfStocks)
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
            
                let temporaryShare=CompanyShares(stockSymbol: stockSymbol,stockValue: stockValue,dateTime: dateTime)
                listOfShares.append(temporaryShare)
                
                i+=1
            }
        }
        catch let error {
            print(error.localizedDescription)
        }
        
    }
    
    
    func valueOf() -> Double {
        var totalValueOfAccount = 0.00
        for share in listOfShares {
            totalValueOfAccount += Double(share.stockValue)
        }
        return totalValueOfAccount
    }

    
    func buy(_ amount:Int,_ symbol:String) {
        for share in listOfShares {
            if share.stockSymbol == symbol && share.stockValue>=0 {//company shares are available
                share.stockValue += Float(amount)
                return
            }
        }
        let currentHour = Calendar.current.component(.hour,from:Date())
        let currentMinute = Calendar.current.component(.minute,from:Date())
        let currentDate = Calendar.current.component(.day,from:Date())
        let currentMonth = Calendar.current.component(.month,from:Date())
        let currentYear = Calendar.current.component(.year,from:Date())
        let dateTime = "\(currentDate)/\(currentMonth)/\(currentYear) \(currentHour):\(currentMinute)"
        let temporaryShare = CompanyShares(stockSymbol: symbol,stockValue: Float(amount),dateTime: dateTime)
        listOfShares.append(temporaryShare)
   }
    
    
    func sell(_ amount:Int,_ symbol:String) {
        for share in listOfShares {
            if share.stockSymbol == symbol && share.stockValue>0 {//company shares are available
                if share.stockValue >= Float(amount) {
                    share.stockValue -= Float(amount)
                    return
                }
                else {
                    share.stockValue = 0.00
                    return
                }
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
        for share in listOfShares {
            // Set the contents
            fileContentToWrite += "\(share.stockSymbol) \(share.stockValue) \(share.dateTime)\n"
        }
        
            do {
                // Write contents to file
                try fileContentToWrite.write(toFile: filePath, atomically: false, encoding: String.Encoding.utf8)
            }
            catch let error as NSError {
                print("An error took place: \(error)")
            }
        
    }
    
    
    func printReport() {
        for share in listOfShares {
            print("\(share.stockSymbol) \(share.stockValue) \(share.dateTime)")
        }
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
