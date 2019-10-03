
import UIKit

class AfterLoginViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate  {
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    @IBOutlet weak var signOutButton: UIBarButtonItem!
    @IBOutlet weak var slidingView: UIView!
    @IBOutlet weak var viewTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var viewLeadingConstraint: NSLayoutConstraint!
    
    var humburgerMenuIsVisible = false
    let arrayOfNotes = ["...1...","This is two","Hey, I am third note"]
    
    //number of views in collection view
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  arrayOfNotes.count
    }
    
    //populate views of collection view
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! myCell
        cell.myTextView.text = arrayOfNotes[indexPath.row]
        print(arrayOfNotes[indexPath.row])
        return cell
        
    }
    
    //This method will be called when you press humburger button.
    @objc func humburgerButtonPressed() {
        
        if !humburgerMenuIsVisible {
            self.humburgerMenuIsVisible = true
            self.viewLeadingConstraint.constant = 150-414
            self.viewTrailingConstraint.constant = 150-414
        }
        else {
            self.humburgerMenuIsVisible = false
            self.viewLeadingConstraint.constant = -414
            self.viewTrailingConstraint.constant = -414
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
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
       // Collection View display settings
        let itemSize = UIScreen.main.bounds.width/3 - 3
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20,left: 0,bottom: 10,right: 0)
        layout.itemSize = CGSize(width: itemSize,height: itemSize)
        
        layout.minimumInteritemSpacing = 3
        layout.minimumLineSpacing = 3
        
        myCollectionView.collectionViewLayout = layout
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


//extension AfterLoginViewController : UICollectionViewDataSource {
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return dataSource.count
//    }

//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "self", for: indexPath) as! CollectionViewCell
//        cell.noteText.text = dataSource[indexPath.row]
//        return cell
//    }
//}
