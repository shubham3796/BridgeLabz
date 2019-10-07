
import UIKit
import CoreData

class AfterLoginViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate  {
    
    @IBOutlet weak var myCollectionView: UICollectionView!
   
    @IBOutlet weak var signOutButton: UIButton!
    @IBOutlet weak var slidingView: UIView!
    @IBOutlet weak var viewTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var viewLeadingConstraint: NSLayoutConstraint!
    
    var humburgerMenuIsVisible = false
    var localArrayOfNotes = [oneNote]()
    fileprivate var longPressGesture = UILongPressGestureRecognizer()
    //number of views in collection view
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  localArrayOfNotes.count
    }
    
    //populate views of collection view
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! myCell
        cell.myTextView.text = localArrayOfNotes[indexPath.row].note
        cell.title.text = localArrayOfNotes[indexPath.row].oneTitle
        
        //print(localArrayOfNotes[indexPath.row])
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let item = localArrayOfNotes.remove(at: sourceIndexPath.item)
        localArrayOfNotes.insert(item,at: destinationIndexPath.item)
        print(localArrayOfNotes)
    }
    
    //do on selecting a note
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        GetData.titleOfNoteToBeEdited = localArrayOfNotes[indexPath.row].oneTitle!
        GetData.textOfNoteToBeEdited = localArrayOfNotes[indexPath.row].note
        performSegue(withIdentifier: "editNote", sender: self)
        
    }

    @IBAction func humburgerClick(_ sender: UIButton) {
        
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
   
    
    func retrieveData(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return}
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        
        do{
            let result = try managedContext.fetch(fetchRequest)
            for data in result as! [NSManagedObject] {
                let title = data.value(forKey: "title") as! String
                let text = data.value(forKey: "noteText") as! String
                self.localArrayOfNotes.append(oneNote(title,text))
            }
        } catch {
            print("Failed")
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        retrieveData()
        viewLeadingConstraint.constant = -414
        viewTrailingConstraint.constant = -414
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    
        let itemsize = UIScreen.main.bounds.width/2 - 3
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top:20,left:1,bottom: 10, right: 1)
        layout.itemSize = CGSize(width: itemsize, height: itemsize)
        layout.minimumInteritemSpacing = 3
        layout.minimumLineSpacing = 3
        myCollectionView.collectionViewLayout = layout
        
        longPressGesture = UILongPressGestureRecognizer(target:self,action: #selector(self.handleLongGesture(gesture:)))
        myCollectionView.addGestureRecognizer(longPressGesture)
    }
    
    //Move cells on being long pressed
    @objc func handleLongGesture(gesture: UILongPressGestureRecognizer){
        switch(gesture.state){
        case .began:
            guard let selectedIndexPath = myCollectionView.indexPathForItem(at: gesture.location(in: myCollectionView)) else {
                break
            }
            myCollectionView.beginInteractiveMovementForItem(at: selectedIndexPath)
        case .changed:
        myCollectionView.updateInteractiveMovementTargetPosition(gesture.location(in: gesture.view))
        case .ended:
            myCollectionView.endInteractiveMovement()
        default:
            myCollectionView.cancelInteractiveMovement()
        }
        
//        for cell in myCollectionView.visibleCells as! myCell{
//            // do something
//
//        }

        
//        for row in 0..<myCollectionView.numberOfItems(inSection: 0){
//
//            let indexPath = NSIndexPath(row:row, section:0)
//
//            let cell:UICollectionViewCell = myCollectionView.cellForItem(at: indexPath as IndexPath) as! myCell
//
//           localArrayOfNotes[indexPath.row].oneTitle = cell.
//        }
        
    }
   
    @IBAction func doOnSignOutClick(_ sender: UIButton) {
        UserDefaults.standard.set(false, forKey: "USERISLOGIN")
        UserDefaults.standard.synchronize()
        
        performSegue(withIdentifier: "signOut", sender: self)
    }
}


