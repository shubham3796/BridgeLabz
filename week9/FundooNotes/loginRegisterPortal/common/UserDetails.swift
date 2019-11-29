import Foundation

struct Inventory : Codable {
    var username : String
}

struct oneNote {
    var note:String
    var oneTitle:String?
    var color:Int?
    var index:Int
    var archived:Bool
    var important:Bool
    var reminderDateTimeInfo:String
    
    init(_ title:String,_ note:String,_ color:Int,_ index:Int,_ archived:Bool,_ important:Bool,_ reminderDateTimeInfo:String) {
        self.oneTitle = title
        self.note = note
        self.color = color
        self.index = index
        self.archived = archived
        self.important = important
        self.reminderDateTimeInfo = reminderDateTimeInfo
        
    }
}

class GetData {
    
    static var myArrayOfInventory = [Inventory]()
    static var arrayOfNotes = [oneNote]()
    static var titleOfNoteToBeEdited = ""
    static var textOfNoteToBeEdited = ""
    static var colorOfNoteToBeEdited = 1
    static var indexOfNoteToBeEdited = 1000
    static var positionOfNoteToBeEdited = 1000
    static var reminderInfoOfNoteToBeEdited = ""
    static var reminderDateOfNoteToBeEdited = Date.getCurrentDate()
    static var archiveStatusOfNoteToBeEdited = false
    static var importantStatusOfNoteToBeEdited = false
    static var viewLayout = 1 //1 is for grid view, 2 is for list view
    //static var colorOfNote = [Int]()
    static var shouldRetrieveData = false
    //static var shouldRetrieveArchiveData = false
    static var noteJustAdded = false
    static var noteJustArchived = false
    static var openArchive = false
    static var localArrayOfNotes = [oneNote]()
    static var arrayOfNoteIndices = [Int]()
    static var arrayOfArchivedNotes = [oneNote]()
    static var arrayOfArchivedNoteIndices = [Int]()
    static var arrayOfReminderedNotes = [oneNote]()
    static var arrayOfReminderedNoteIndices = [Int]()
    
    
    
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
