
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
    var arrayOfNoteIndices = [Int]()
    let arrayOfColors = [UIColor.gray,UIColor.red,UIColor.orange,UIColor.yellow,UIColor.blue,UIColor.green,UIColor.purple,UIColor.magenta,UIColor.brown]
    
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
        let cellColorIndex = localArrayOfNotes[indexPath.row].color //an integer value
        cell.backgroundColor = arrayOfColors[cellColorIndex! - 1]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func saveArrayOfIndices(){
        var i=0
        if  arrayOfNoteIndices.count == localArrayOfNotes.count{
            while i<localArrayOfNotes.count{
                arrayOfNoteIndices[i] = localArrayOfNotes[i].index
                i+=1
            }
        }
        else {
            while i<localArrayOfNotes.count{
                arrayOfNoteIndices.append(localArrayOfNotes[i].index)
                i+=1
            }
        }
        
        UserDefaults.standard.set(arrayOfNoteIndices, forKey: "SavedArrayOfIndices")
        UserDefaults.standard.synchronize()
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        let item = localArrayOfNotes.remove(at: sourceIndexPath.item)
        localArrayOfNotes.insert(item,at: destinationIndexPath.item)
        //print(localArrayOfNotes)
        
        //set and save the array of indices using the local array of notes
        saveArrayOfIndices()
        //print(arrayOfNoteIndices)
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
   
    func sortLocalArrayOfNotes() {
        var i=0
        var sortedArray = [oneNote]()
        
        while i<localArrayOfNotes.count {
            if arrayOfNoteIndices.count == 0 {
                saveArrayOfIndices()
            }
            sortedArray.append(localArrayOfNotes[arrayOfNoteIndices[i]-1])
            i+=1
        }
        localArrayOfNotes = sortedArray
    }
    
    func retrieveData(){
        //retrieve the saved(as user default) array of indices
        arrayOfNoteIndices = UserDefaults.standard.object(forKey: "SavedArrayOfIndices") as? [Int] ?? [Int]()
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return}
        var index = 0
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        
        do{
            let result = try managedContext.fetch(fetchRequest)
            for data in result as! [NSManagedObject] {
                index += 1
                let title = data.value(forKey: "title") as! String
                let text = data.value(forKey: "noteText") as! String
                let myColorData = data.value(forKey: "color") as! Data
                var foundFlag=false
                    if let color = UIColor.color(data: myColorData) {
                        var i=0
                        while i < arrayOfColors.count && foundFlag == false {
                            if color == arrayOfColors[i]{
                                self.localArrayOfNotes.append(oneNote(title,text,i+1,index))
                                foundFlag = true
                            }
                            i+=1
                        }
                    }
            }
            sortLocalArrayOfNotes()
        } catch {
            print("Failed")
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        retrieveData()
        viewLeadingConstraint.constant = -414
        viewTrailingConstraint.constant = -414
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
    }
    
   
    @IBAction func doOnSignOutClick(_ sender: UIButton) {
        UserDefaults.standard.set(false, forKey: "USERISLOGIN")
        UserDefaults.standard.synchronize()
        
        //set and save the array of indices using the local array of notes
        saveArrayOfIndices()
        performSegue(withIdentifier: "signOut", sender: self)
    }
}


