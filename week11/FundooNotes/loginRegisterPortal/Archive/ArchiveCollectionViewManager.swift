
import UIKit

extension ArchiveDashboardController : UICollectionViewDataSource  ,UICollectionViewDelegate {

    //number of views in collection view
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  filteredArrayOfArchivedNotes.count
    }
    
    //populate views of collection view
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: "archiveCell", for: indexPath) as! myArchiveCell
        cell = myArchiveCell.setArchiveCellParameters(filteredArrayOfArchivedNotes[indexPath.row],cell) as! myArchiveCell
        return cell
    }
    
    //do on selecting a note
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        ArchiveModel.saveDetailsOfNoteToBeEdited(indexPath.row)
        performSegue(withIdentifier: "editArchivedNote", sender: self)
        
    }
}
