
import UIKit
import CoreData

class ArchiveDashboardController: UIViewController {
    
    
    @IBOutlet weak var archiveCollectionView: UICollectionView!
    
    var arrayOfArchivedNoteIndices = [Int]()
    var filteredArrayOfArchivedNotes = [oneNote]()
    var archiveDashboardControllerDelegate = ArchiveDashboardControllerDelegate()
    var archiveModel = ArchiveModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if GetData.shouldRetrieveArchiveNotes {
            if Connectivity.isConnectedToInternet{
                archiveModel.retrieveArchiveNotes{ [weak self] (noteList: [oneNote]) in
                    self?.saveArchiveNotesFromCoreData(noteList: noteList)
                }
            }
            else {
                archiveModel.retrieveRemoteArchiveNotes{ [weak self] (noteList: [oneNote]) in
                    self?.saveArchiveNotesFromWeb(noteList: noteList)
                }
            }
            
        }

        let itemsize = UIScreen.main.bounds.width/2 - 17
        archiveCollectionView.collectionViewLayout = archiveDashboardControllerDelegate.setLayoutOfCollectionView(itemsize)
    }
    
    private func saveArchiveNotesFromCoreData(noteList: [oneNote]) {
        filteredArrayOfArchivedNotes = noteList
        archiveCollectionView.reloadData()
    }
    
    private func saveArchiveNotesFromWeb(noteList: [oneNote]) {
        filteredArrayOfArchivedNotes = noteList
        archiveCollectionView.reloadData()
    }

    @IBAction func backButtonPress(_ sender: UIButton) {
        GetData.shouldRetrieveData = true
        GetData.indexOfNoteToBeEdited = 1000
        performSegue(withIdentifier: "backFromArchive", sender: self)
    }
    
}
