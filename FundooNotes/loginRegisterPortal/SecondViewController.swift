import UIKit

class SecondViewController: UIViewController {
    
    
    @IBOutlet weak var userNameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    @IBOutlet weak var registrationStatusTextField: UITextField!
    
    var myArrayofRiceInventory = [Inventory]()
    var myArrayofRiceInventory2 = [String:[Inventory]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func doOnRegisterClick(_ sender: UIButton) {
        
        if passwordTextField.text == confirmPasswordTextField.text {
            //Save the user login credentials in login.json file
            let filepath = "/Users/admin/Desktop/FundooNotes/loginRegisterPortal/login.json"
            let fileData = FileManager.default.contents(atPath: filepath)
            let encoder = JSONEncoder()
            let decoder = JSONDecoder()
            
            let d1 = Inventory(username: userNameTextField.text!, password: passwordTextField.text!)
            do{
                
                let jsonDictionary : [String :[Inventory]] = try decoder.decode(Dictionary.self, from: fileData!)
                myArrayofRiceInventory = jsonDictionary["details"]!
                myArrayofRiceInventory.append(d1)
                
                myArrayofRiceInventory2 = ["details": myArrayofRiceInventory]
                let jsondata = try encoder.encode(myArrayofRiceInventory2)
                let url = URL(fileURLWithPath: filepath)
                try jsondata.write(to: url)
                
                let alertController:UIAlertController = UIAlertController(title: "Message", message: "Registration Successful", preferredStyle: UIAlertController.Style.alert)
                let alertAction:UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:nil)
                alertController.addAction(alertAction)
                present(alertController, animated: true, completion: nil)
                
                
            }catch let error{
                print("Not Found")
            }
        }
        else
        {//Show this message on app screen if passwords don't match.
            let alertController:UIAlertController = UIAlertController(title: "Message", message: "Passwords do not match. Please retry.", preferredStyle: UIAlertController.Style.alert)
            let alertAction:UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:nil)
            alertController.addAction(alertAction)
            present(alertController, animated: true, completion: nil)
        }

    }
    
}
