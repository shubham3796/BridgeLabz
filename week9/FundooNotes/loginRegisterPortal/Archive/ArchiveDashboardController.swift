
import UIKit
import CoreData

class ArchiveDashboardController: UIViewController {
    
    
    @IBOutlet weak var archiveCollectionView: UICollectionView!
    
    var arrayOfArchivedNoteIndices = [Int]()
    var archiveDashboardControllerDelegate = ArchiveDashboardControllerDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        archiveDashboardControllerDelegate.retrieveData()
        let itemsize = UIScreen.main.bounds.width/2 - 17
        archiveCollectionView.collectionViewLayout = archiveDashboardControllerDelegate.setLayoutOfCollectionView(itemsize)
    }

    @IBAction func backButtonPress(_ sender: UIButton) {
        GetData.shouldRetrieveData = false
        GetData.indexOfNoteToBeEdited = 1000
        performSegue(withIdentifier: "backFromArchive", sender: self)
    }
    
}
