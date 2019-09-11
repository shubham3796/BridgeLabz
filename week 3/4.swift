import Foundation

import Foundation

struct Inventory : Codable {
    var stockName : String?
    var numberOfShares : Int?
    var sharePrice : Float?
    var stockValue : Float?
    
//    public init(_ stockName:String, _ numberOfShares:Int,_ sharePrice:Float, _ stockValue:Float){
//        self.stockName = stockName
//        self.numberOfShares = numberOfShares
//        self.sharePrice = sharePrice
//        self.stockValue = stockValue
//    }
}

let filePath = "/Users/bridgelabz/Desktop/shubhamVaishnav/1/File.json"  // file path
let fileData = FileManager.default.contents(atPath: filePath)

//print(fileData!)
let decoder = JSONDecoder()
do {
    let jsonDictionary : [String: [Inventory]] = try decoder.decode(Dictionary.self, from: fileData!)
    //    print(jsonDictionary)
    
    let arrayOfInventories = jsonDictionary["InventoryFactory"]
    //    print(myArrayOfInventory!)
    //var stock : Inventory
    for stock in arrayOfInventories! {
        let stockPrice = Float(stock.sharePrice!)*Float(stock.numberOfShares!)
        print("Total price of \(stock.stockName!) is \(stockPrice)")

    }
    
} catch let error {
    print(error.localizedDescription)
}
