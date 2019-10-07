import UIKit

class SecondViewController: UIViewController {
    
    
    @IBOutlet weak var userNameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    @IBOutlet weak var registrationStatusTextField: UITextField!
    
    @IBOutlet weak var registerButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerButton.layer.cornerRadius = 5.0
        self.navigationItem.title = nil
        // Do any additional setup after loading the view.
    }
    
     func displayAlertMessage(as receivedMessage:String){
        //Show this message on app screen if passwords don't match, with OK option also.
        let alertMessage = AlertMessageViewController.AlertMessage(uiViewController: self,title: "Message",receivedMessage: receivedMessage,receivedOption: "OK")
        AlertMessageViewController.displayMessage(as: alertMessage)
    }
    
//    func createData() {
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return}
//
//        let managedContext = appDelegate.persistentContainer.viewContext
//
//        let userEntity = NSEntityDescription.entity(forEntityName: "User",in: managedContext)!
//
//        let user = NSManagedObject(entity:userEntity. insertInfo: managedContext)
//        user.serValue(userNameTextField.text, forKeyPath: "userName")
//
//    }

    @IBAction func backButtonClick(_ sender: UIButton) {
         performSegue(withIdentifier: "backToLoginPage", sender: self)
    }
    @IBAction func doOnRegisterClick(_ sender: UIButton) {
        var alertMessageFlag : Bool
        
        if passwordTextField.text == confirmPasswordTextField.text {
           let defaultString = ""
            let _: Bool = KeychainWrapper.standard.set("\(passwordTextField.text ?? defaultString)", forKey: "\(userNameTextField.text ?? defaultString)") // Save password in keychain
            
            let d1 = Inventory(username: userNameTextField.text!)
            GetData.myArrayOfInventory.append(d1)// update model's array of inventory
            
           alertMessageFlag = GetData.writeToJsonFile(data: d1)
            if alertMessageFlag == true {
                displayAlertMessage(as: "Registration Successful!")
            }
            //createData()
        }
        else
        {//Show this message on app screen if passwords don't match.
            displayAlertMessage(as: "Passwords do not match. Please retry.")
        }

    }
    
}
