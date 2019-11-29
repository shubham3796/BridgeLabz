
import UIKit
import CoreData

class ArchiveDashboardController: UIViewController {
    
    
    @IBOutlet weak var archiveCollectionView: UICollectionView!
    
    var arrayOfArchivedNoteIndices = [Int]()
    var dataAndLayoutHandler = ArchiveDashboardControllerDelegate()
    
    let arrayOfColors = [UIColor.gray,UIColor.red,UIColor.orange,UIColor.yellow,UIColor.blue,UIColor.green,UIColor.purple,UIColor.magenta,UIColor.brown]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataAndLayoutHandler.retrieveData()
        let itemsize = UIScreen.main.bounds.width/2 - 17
        archiveCollectionView.collectionViewLayout = dataAndLayoutHandler.setLayoutOfCollectionView(itemsize)
    }

    @IBAction func backButtonPress(_ sender: UIButton) {
        GetData.shouldRetrieveData = false
        GetData.indexOfNoteToBeEdited = 1000
        performSegue(withIdentifier: "backFromArchive", sender: self)
    }
    
}
