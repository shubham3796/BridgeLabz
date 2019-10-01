
import UIKit

class AfterLoginViewController: UIViewController {
    
    var humburgerMenuIsVisible = false
    
    @IBOutlet weak var signOutButton: UIBarButtonItem!
    @IBOutlet weak var slidingView: UIView!
    @IBOutlet weak var viewTrailingConstraint: NSLayoutConstraint!
    
    
    @IBOutlet weak var viewLeadingConstraint: NSLayoutConstraint!
    
    
    //This method will call when you press button.
    @objc func humburgerButtonPressed() {
        
        if !humburgerMenuIsVisible {
            self.humburgerMenuIsVisible = true
            self.viewLeadingConstraint.constant = 150-414
            self.viewTrailingConstraint.constant = 150-414
            //print("1")
        }
        else {
            self.humburgerMenuIsVisible = false
            self.viewLeadingConstraint.constant = -414
            self.viewTrailingConstraint.constant = -414
           // print("2")
        }
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseIn, animations: {
            self.view.layoutIfNeeded()
        }) { (animationComplete) in
            print("Animation complete")
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //create a new button
        let button = UIButton(type: .custom)
        //set image for button
        button.setImage(UIImage(named: "humburgerIcon2.png"), for: .normal)
        //add function for button
        button.addTarget(self, action: #selector(humburgerButtonPressed), for: .touchUpInside)
        //set frame
        button.frame = CGRect(x: 0, y: 0, width: 50, height: 51)
        let barButton = UIBarButtonItem(customView: button)
        //assign button to navigationbar
        self.navigationItem.leftBarButtonItem = barButton
        
        viewLeadingConstraint.constant = -414
        viewTrailingConstraint.constant = -414
        
      // signOutButton.layer.cornerRadius = 5.0
    }
    
    // Do any additional setup after loading the view.
    
//    @IBAction func doOnSignOutClick(_ sender: UIBarButtonItem) {
//
//        UserDefaults.standard.set(false, forKey: "USERISLOGIN")
//        UserDefaults.standard.synchronize()
//
//        performSegue(withIdentifier: "signOut", sender: self)
//
//
//    }
    @IBAction func doOnSignOut2(_ sender: UIButton) {
        UserDefaults.standard.set(false, forKey: "USERISLOGIN")
        UserDefaults.standard.synchronize()
        
        //performSegue(withIdentifier: "signOut", sender: self)
    }
    
    @IBAction func doOnSignOut(_ sender: UIBarButtonItem) {
        UserDefaults.standard.set(false, forKey: "USERISLOGIN")
        UserDefaults.standard.synchronize()
        
        performSegue(withIdentifier: "signOut", sender: self)
    }
}
