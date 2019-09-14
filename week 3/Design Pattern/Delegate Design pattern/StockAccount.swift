import Foundation

public class StockAccount {
    var listOfShares : [CompanyShares]
    var fileName:String
    var shareValue:Float
    
    init(_ filename:String) {//create a new account from file
        self.fileName=filename
        self.listOfShares = []
        self.shareValue = 1.50 //Constant for a company
        
        let inputOutputDelegate = InputOutput(self)
        inputOutputDelegate.inputFromFile()
    }
    
    
    func valueOf() -> Double {
        var totalValueOfAccount = 0.00
        for share in listOfShares {
            totalValueOfAccount += Double(share.stockValue)
        }
        return totalValueOfAccount
    }
    
    
    func buy(_ amount:Int,_ symbol:String) {
        let buySellShareDelegate = buySellShare(self)
        buySellShareDelegate.buy(amount,symbol)
    }
    
    
    func sell(_ amount:Int,_ symbol:String) {
        let buySellShareDelegate = buySellShare(self)
        buySellShareDelegate.sell(amount,symbol)
    }
    
    
    func save(_ fileName:String) {//save contents to this file
        let inputOutputDelegate = InputOutput(self)
        inputOutputDelegate.inputFromFile()
    }
    
    func printReport() {
        for share in listOfShares {
            print("\(share.stockSymbol) \(share.stockValue) \(share.dateTime)")
        }
    }
    
}
