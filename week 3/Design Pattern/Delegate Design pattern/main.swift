
import Foundation

var stockAccount1=StockAccount("week3prob5.txt")
stockAccount1.buy(8,"c")
stockAccount1.buy(6,"b")
stockAccount1.sell(2,"c")
stockAccount1.sell(2,"a")
stockAccount1.buy(10,"d")
stockAccount1.save("week3prob5.txt")
stockAccount1.printReport()
