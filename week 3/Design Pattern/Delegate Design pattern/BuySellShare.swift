import Foundation

class buySellShare {//Delegate class
    var stockAccount : StockAccount
    func buy(_ amount:Int,_ symbol:String) {
        for share in stockAccount.listOfShares {
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
        stockAccount.listOfShares.append(temporaryShare)
    }//end func buy
    
    
    func sell(_ amount:Int,_ symbol:String){
        for share in stockAccount.listOfShares {
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
    }// end func sell
    
    init(_ stockAccount : StockAccount){
        self.stockAccount = stockAccount
    }
    
}//end class buy sell share
