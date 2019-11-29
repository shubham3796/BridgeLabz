

import UIKit

class AlertMessageViewController {
    struct AlertMessage{
        var uiViewController:UIViewController
        var title:String
        var receivedMessage:String
        var receivedOption:String
    }
   

    static func displayMessage(as alertMessage:AlertMessage){//Display received message with OK option
        let alertController:UIAlertController = UIAlertController(title: alertMessage.title, message: alertMessage.receivedMessage, preferredStyle: UIAlertController.Style.alert)
            let alertAction:UIAlertAction = UIAlertAction(title: alertMessage.receivedOption, style: UIAlertAction.Style.default, handler:nil)
            alertController.addAction(alertAction)
            alertMessage.uiViewController.present(alertController, animated: true, completion: nil)
        }
    

}
