
import Foundation

import Foundation

struct Inventory : Codable {
    var name : String?
    var weight : Int?
    var price : Int?
}

let filePath = "/Users/bridgelabz/Desktop/shubhamVaishnav/1/food.json"  // file path
let fileData = FileManager.default.contents(atPath: filePath)

//print(fileData!)

let decoder = JSONDecoder()
do {
    let jsonDictionary : [String: [Inventory]] = try decoder.decode(Dictionary.self, from: fileData!)
    //    print(jsonDictionary)
    
    let arrayOfInventories = jsonDictionary["Food_Factory"]
    //    print(myArrayOfInventory!)
    
    for grain in arrayOfInventories! {
        print("Total price of \(grain.name!) is")
        let totalGrainPrice = Float(grain.price!)*Float(grain.weight!)
        print(totalGrainPrice)
    }
    
} catch let error {
    print(error.localizedDescription)
}
