
import Foundation

class Stock {
    var arrayOfStockNames = [String]()
    var arrayOfNumberOfShares = [Int]()
    var arrayOfSharePrices = [Float]()
    var arrayOfStockValues = [Float]()
    func calculateStockValue(_ name:String,_ numberOfShares:Int,_ sharePrice:Float) {
        arrayOfStockNames.append(name)
        arrayOfNumberOfShares.append(numberOfShares)
        arrayOfSharePrices.append(sharePrice)
        arrayOfStockValues.append(Float(numberOfShares)*sharePrice)
    }
}

class StockPortfolio {
    var totalStockValue : Float
    var allStocks:Stock
    
    init(_ allStocks:Stock) {
        self.totalStockValue = 0.00
        self.allStocks=allStocks
    }
    
    func claculateTotalStockValue() -> Float{
        for i in 0...(allStocks.arrayOfStockNames.count - 1) {
            print(i)
            totalStockValue += allStocks.arrayOfStockValues[i]
        }
        return totalStockValue
    }
    
    func printStockReport() {
        print("                                 STOCK REPORT")
       
        for i in 0...(allStocks.arrayOfStockNames.count - 1) {
            print("STOCK NAME: \(allStocks.arrayOfStockNames[i]),  NUMBER OF SHARES: \(allStocks.arrayOfNumberOfShares[i]),  PRICE OF SHARE: \(allStocks.arrayOfSharePrices[i]),  TOTAL STOCK VALUE: \(allStocks.arrayOfStockValues[i])")
        }
        print("")
        print("Total value of stock is \(totalStockValue)")
    }
    
}

print("Enter number of stocks")
var temporaryString = readLine()
let numberOfStocks = Int(temporaryString!)
var name:String
var numberOfShares:Int
var sharePrice:Float

let stockObject = Stock()

for i in 0...(numberOfStocks!-1){
    print("Enter Stock Name of stock \(i+1)")
    name=readLine()!
    
    print("Enter number of shares of stock \(i+1)")
    temporaryString=readLine()
    numberOfShares=Int(temporaryString!)!
    
    print("Enter share price \(i+1)")
    temporaryString=readLine()
    sharePrice=Float(temporaryString!) as! Float
    
    stockObject.calculateStockValue(name,numberOfShares,sharePrice)
    
}
print(stockObject.arrayOfStockNames)
print(stockObject.arrayOfNumberOfShares)
print(stockObject.arrayOfSharePrices)
print(stockObject.arrayOfStockValues)

let stockPortfolioObject = StockPortfolio(stockObject)
let totalStockValue = stockPortfolioObject.claculateTotalStockValue()
stockPortfolioObject.printStockReport()

