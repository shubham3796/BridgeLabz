
import UIKit
import CoreData

class DashboardController: UIViewController {
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var signOutButton: UIButton!
    
    @IBOutlet weak var slidingView: UIView!
    
    @IBOutlet weak var slidingViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var slidingviewTrailingConstraint: NSLayoutConstraint!
    
    var humburgerMenuIsVisible = false
    var searchActive : Bool = false
    let arrayOfColors = DashboardControllerDelegate.arrayOfColors
    var filteredArrayOfNotes=[oneNote]()
    fileprivate var longPressGesture = UILongPressGestureRecognizer()
    let dashBoardControllerDelegate = DashboardControllerDelegate()
    var dashBoardModel = DashBoardModel()
    
    
    ///////////////////////////////////////////////////////////////////////////////////////////
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "dashboardCollectionViewLayout"),
                                               object: nil,
                                               queue: nil,
                                               using: setCollectionViewLayout)
        dashBoardControllerDelegate.setLayoutOfCollectionView(UIScreen.main.bounds.width)
        
        
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        humburgerMenuIsVisible = true
        setViewConstraints(-414, -414)
        
        print("Dashboard controller -> 46 -> filteredArrayOfNotes \(filteredArrayOfNotes)")
        print("Dashboard controller -> 47 -> arrayOfNoteIndices \(GetData.arrayOfNoteIndices)")
        
        if GetData.shouldRetrieveData == true {
            
            //DashBoardModel.clearAllNotesBeforeRetrieving()
            
            dashBoardModel.getNotesFromServer{ [weak self] (noteList: [oneNote]) in
                self?.useData(noteList: noteList)
                   }
            
                //dashBoardModel.retrieveNotesFromCoreData()
            }
            else {
                if !searchActive{
                    filteredArrayOfNotes = GetData.localArrayOfNotes
                }
            }
        
        
        
        longPressGesture = UILongPressGestureRecognizer(target:self,action: #selector(self.handleLongGesture(gesture:)))
        myCollectionView.addGestureRecognizer(longPressGesture)
        
        
        //myCollectionView.reloadData()
    }
    
    private func useData(noteList: [oneNote]) {
        if !searchActive{
            filteredArrayOfNotes = noteList
        }
        
        print("Dashboard controller -> 78 -> filteredArrayOfNotes \(filteredArrayOfNotes)")
        print("Dashboard controller -> 79 -> arrayOfNoteIndices \(GetData.arrayOfNoteIndices)")
        myCollectionView.reloadData()
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
        NotificationCenter.default
            .removeObserver(self,
                            name: Notification.Name("dashboardCollectionViewLayout") ,
                            object: nil)
    }
    
    func setCollectionViewLayout(notification:Notification) -> Void{
        guard let layout = notification.userInfo!["layout"] else {return}
        myCollectionView.collectionViewLayout = layout as! UICollectionViewLayout
    }
    
    func setViewConstraints(_ leadingConstraint:Int,_ trailingConstraint:Int){
        self.slidingViewLeadingConstraint.constant = CGFloat(leadingConstraint)
        self.slidingviewTrailingConstraint.constant = CGFloat(trailingConstraint)
    }
    
    
    //FUNCTIONALITIES OF BUTTONS
    
    @IBAction func humburgerClick(_ sender: UIButton) {
        if !humburgerMenuIsVisible {
            setViewConstraints(150-414,150-414)
        }
        else {
            setViewConstraints(-414,-414)
        }
        self.humburgerMenuIsVisible = !self.humburgerMenuIsVisible
        
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseIn, animations: {
            self.view.layoutIfNeeded()
        }) { (animationComplete) in
            print("Animation complete")
        }
    }
    
    @IBOutlet weak var changeViewButton: UIButton!
    
    @IBAction func changeView(_ sender: UIButton) {
        if GetData.viewLayout == 1{//show grid view
            GetData.viewLayout = 2
            changeViewButton.setImage(UIImage(named: "gridView.png"), for: .normal)
            myCollectionView.reloadData()
        }
        else {//show list view
            GetData.viewLayout = 1
            changeViewButton.setImage(UIImage(named: "listView.png"), for: .normal)
            myCollectionView.reloadData()
        }
        dashBoardControllerDelegate.setLayoutOfCollectionView(UIScreen.main.bounds.width)
    }
    
    @IBAction func showArchive(_ sender: UIButton) {
        performSegue(withIdentifier: "showArchive", sender: self)
    }
    
    @IBAction func showReminders(_ sender: UIButton) {
        performSegue(withIdentifier: "showReminders", sender: self)
    }
    
    
    
    @IBAction func doOnSignOutClick(_ sender: UIButton) {
        UserDefaults.standard.set(false, forKey: "USERISLOGIN")
        UserDefaults.standard.synchronize()
        
        print("125 - DashboardController -> \(GetData.arrayOfNoteIndices)")
        //set and save the array of indices using the local array of notes
        DashBoardModel.saveArrayOfIndices()
        print("128 - DashboardController -> \(GetData.arrayOfNoteIndices)")
        GetData.shouldRetrieveData = true
        performSegue(withIdentifier: "signOut", sender: self)
    }
}






