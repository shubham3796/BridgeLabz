import UIKit
import Alamofire

struct Login: Encodable{
    let email: String
    let password: String
}

class ViewController: UIViewController {
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewDidLoad() {
            super.viewDidLoad()
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
    
//    func checkUsernamePassword()->Bool
//    {
//        for inventory in GetData.myArrayOfInventory {
//            if inventory.username == userNameTextField.text {
//                if let password: String = KeychainWrapper.standard.string(forKey: "\(userNameTextField.text ?? "Shubham")" ) {
//                    if passwordTextField.text == password
//                    {return true}
//                    else {return false}
//                }
//            }
//        }
//        displayAlertMessage(as: "Username not found. Kindly register yourself first")
//        return false
//    }
    
    @IBAction func doRegisterClick(_ sender: UIButton) {
        performSegue(withIdentifier: "register", sender: self)
    }
    
    @IBAction func doOnLoginClick(_ sender: UIButton) {
        let emailId = userNameTextField.text!
        let password = passwordTextField.text!
        let login = Login(email: "\(emailId)@gmail.com",password: "\(password)")
        
        let loginRequestUrl = "http://fundoonotes.incubation.bridgelabz.com/api/user/login"
        
        AF.request(
            loginRequestUrl,
            method: .post,
            parameters: login,
            encoder: JSONParameterEncoder.default
            )
            .validate(contentType: ["application/json"])
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                switch response.result {
                case .success(let JSON):
                    let js = JSON as! NSDictionary
                    UserDefaults.standard.set(true, forKey: "USERISLOGIN")
                    UserDefaults.standard.set(js["id"]!, forKey: "accessToken")
                    UserDefaults.standard.synchronize()
                    self.performSegue(withIdentifier: "AfterLogin", sender: self)
                case .failure(_):
                    self.displayAlertMessage(as: "Username or password is incorrect.")
                }
            }
        }
}

