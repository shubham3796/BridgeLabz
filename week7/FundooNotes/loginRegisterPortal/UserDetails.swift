import Foundation

struct Inventory : Codable {
    var username : String
}

struct oneNote {
    var note:String
    var oneTitle:String?
    var color:Int?
    var index:Int
    init(_ title:String,_ note:String,_ color:Int,_ index:Int) {
        self.oneTitle = title
        self.note = note
        self.color = color
        self.index = index
    }
}

class GetData {
    
    static var myArrayOfInventory = [Inventory]()
    static var arrayOfNotes = [oneNote]()
    static var titleOfNoteToBeEdited = ""
    static var textOfNoteToBeEdited = ""
    //static var colorOfNote = [Int]()
    
    static func writeToJsonFile(data inventory:Inventory) -> Bool{
        var myArrayofRiceInventory = [Inventory]()
        var myArrayofRiceInventory2 = [String:[Inventory]]()
        var alertMessageFlag = false

        //Save the user login credentials in login.json file
        let filepath = "/Users/admin/Desktop/week7/FundooNotes/loginRegisterPortal/login.json"
        let fileData = FileManager.default.contents(atPath: filepath)
        let encoder = JSONEncoder()
        let decoder = JSONDecoder()
        do{
            let jsonDictionary : [String :[Inventory]] = try decoder.decode(Dictionary.self, from: fileData!)
            
            myArrayofRiceInventory = jsonDictionary["details"]!
            myArrayofRiceInventory.append(inventory)// update inventory to list of inventories to be added in json file
            myArrayofRiceInventory2 = ["details": myArrayofRiceInventory]
            let jsondata = try encoder.encode(myArrayofRiceInventory2)
            let url = URL(fileURLWithPath: filepath)
            try jsondata.write(to: url)
            alertMessageFlag = true  //displayAlertMessage(as: "Registration Successful!")
            return alertMessageFlag
        }catch let error{
            print("Error : \(error)")
        }
        return alertMessageFlag
    }
    
    static func readFromJsonFile(){
        let filePath = "/Users/admin/Desktop/week7/FundooNotes/loginRegisterPortal/login.json"  // file path
        let fileData = FileManager.default.contents(atPath: filePath)
        let decoder = JSONDecoder()
        do{
            
            let jsonDictionary : [String: [Inventory]] = try decoder.decode(Dictionary.self, from: fileData!)
            
            GetData.myArrayOfInventory = jsonDictionary["details"]!
            
        }catch let error{
            print("Error: \(error)")
        }
    }
}
