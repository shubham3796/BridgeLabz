
import UIKit

//struct ResponseData : Decodable{
//    var person:[Person]
//}
struct Person : Codable {
    var name:String
    var age:Int
    var city:String
}


class ViewController: UIViewController {

    @IBOutlet weak var labelName: UILabel!
    
    override func viewDidLoad() {
        let filepath = "/Users/admin/Desktop/BridgeLabz/Developer/marvel.json"
        let fileData = FileManager.default.contents(atPath: filepath)
        let decoder = JSONDecoder()
        var arrayOfPersons = [Person]()
        do{
            
            let jsonDictionary : [String : [Person]] = try decoder.decode(Dictionary.self, from: fileData!)
            arrayOfPersons = jsonDictionary["details"]!
        } catch let error {
            print("JSON file Not Found")
        }
        labelName.text = "\(arrayOfPersons[1].age)"
        
    }

    
}


