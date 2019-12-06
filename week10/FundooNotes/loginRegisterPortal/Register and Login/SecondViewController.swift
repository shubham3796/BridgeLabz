import UIKit
import Alamofire

struct Register: Encodable{
    let firstName:String
    let lastName:String
    let service:String = "advance" // takes 2 values - "basic","advance".
    let email: String
    let password: String
}

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
            
            ////////////////////
            let emailId = userNameTextField.text!
            let password = passwordTextField.text!
            let register = Register(firstName: "\(emailId)", lastName: "\(emailId)", email: "\(emailId)@gmail.com", password: "\(password)")
            print("register -> \(register)")
            AF.request("http://fundoonotes.incubation.bridgelabz.com/api/user/userSignUp",
                       method: .post,
                       parameters: register,
                       encoder: JSONParameterEncoder.default).response { response in
                        debugPrint(response)
            }
            ////////////////////
            
           alertMessageFlag = GetData.writeToJsonFile(data: d1)
            if alertMessageFlag == true {
                displayAlertMessage(as: "Registration Successful!")
            }
        }
        else
        {//Show this message on app screen if passwords don't match.
            displayAlertMessage(as: "Passwords do not match. Please retry.")
        }

    }
    
}
