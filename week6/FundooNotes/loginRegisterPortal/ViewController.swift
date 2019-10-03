import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewDidLoad() {
            super.viewDidLoad()
        
//        if UserDefaults.standard.bool(forKey: "USERISLOGIN") == true {
//            let afterLoginVC = self.storyboard?.instantiateViewController(withIdentifier:"AfterLoginViewcontroller") as! AfterLoginViewController
//            self.navigationController?.pushViewController(afterLoginVC, animated: false )
//        }
            GetData.readFromJsonFile() //Read and store the contents of the file "login.json" in the array "myArrayOfInventory"
            self.navigationItem.leftBarButtonItem=nil
            self.navigationItem.hidesBackButton=true
            loginButton.layer.cornerRadius = 5.0
            registerButton.layer.cornerRadius = 5.0
        

        }
    
    
    func displayAlertMessage(as receivedMessage:String){
        //Show this message on app screen if passwords don't match, with OK option also.
        let alertMessage = AlertMessageViewController.AlertMessage(uiViewController: self,title: "Message",receivedMessage: receivedMessage,receivedOption: "OK")
        AlertMessageViewController.displayMessage(as: alertMessage)
    }
    
    func checkUsernamePassword()->Bool
    {
        for inventory in GetData.myArrayOfInventory {
            if inventory.username == userNameTextField.text {
                if let password: String = KeychainWrapper.standard.string(forKey: "\(userNameTextField.text ?? "Shubham")" ) {
                    if passwordTextField.text == password
                    {return true}
                    else {return false}
                }
            }
        }
        displayAlertMessage(as: "Username not found. Kindly register yourself first")
        return false
    }
    
    @IBAction func doOnLoginClick(_ sender: UIButton) {
        if checkUsernamePassword() {//i.e. if user details have matched
            
            UserDefaults.standard.set(true, forKey:"USERISLOGIN")
           // UserDefaults.standard.synchronize()
            
            performSegue(withIdentifier: "AfterLogin", sender: self)
            }
        else
        {
            displayAlertMessage(as: "Username orpassword is incorrect.")
        }
    }
}

