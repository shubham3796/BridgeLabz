import UIKit

class ViewController: UIViewController {

    var myArrayofInventory = [Inventory]()
    
//    var str: String?
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
        override func viewDidLoad() {
            super.viewDidLoad()
            
            //Read and store the contents of the file "login.json" in the array "myArrayOfInventory"
            let filePath = "/Users/admin/Desktop/FundooNotes/loginRegisterPortal/login.json"  // file path
            let fileData = FileManager.default.contents(atPath: filePath)
            let decoder = JSONDecoder()
            do{
                
                let jsonDictionary : [String: [Inventory]] = try decoder.decode(Dictionary.self, from: fileData!)
                myArrayofInventory = jsonDictionary["details"]!
                
            }catch let error{
                print("Not Found")
            }
        }
    
    func checkUsernamePassword()->Bool
    {
        for i in myArrayofInventory{
            
            if userNameTextField.text == i.username && passwordTextField.text == i.password
            {
                return true
            }
            
        }
        return false
    }

    
    @IBAction func doOnLoginClick(_ sender: UIButton) {
        
        if checkUsernamePassword()
        {
            print("Yes")
            performSegue(withIdentifier: "AfterLogin", sender: self)
        }
        else
        {//Show this message on app screen when email id or password entered by the user are wrong.
            let alertController:UIAlertController = UIAlertController(title: "Message", message: "Email Id or Password is incorrect", preferredStyle: UIAlertController.Style.alert)
            let alertAction:UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:nil)
            alertController.addAction(alertAction)
            present(alertController, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func printList(_ sender: UIButton) {
        UserLoginCredentials.printList()
    }
}

