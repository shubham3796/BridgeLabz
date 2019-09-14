import Foundation

class InputOutput{//Delegate class
    
    var stockAccount:StockAccount
    
    func inputFromFile() {
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
                stockAccount.listOfShares.append(temporaryShare)
                
                i+=1
            }
        }
        catch let error {
            print(error.localizedDescription)
        }
    }
    
    func outputToFile(){
        var filePath = ""
        // Fine documents directory on device
        let dirs : [String] = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true)
        if dirs.count > 0 {
            let dir = dirs[0] //documents directory
            filePath = dir.appending("/" + stockAccount.fileName)
            print("Local path where the output file is saved = \(filePath)")
        } else {
            print("Could not find local directory to store file")
            //return
        }
        var fileContentToWrite = ""
        for share in stockAccount.listOfShares {
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
    
    init(_ stockAccount:StockAccount){
        self.stockAccount = stockAccount
    }
    
}
