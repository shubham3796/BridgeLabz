
import UIKit

extension ArchiveDashboardController : UICollectionViewDataSource  ,UICollectionViewDelegate {

    //number of views in collection view
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  GetData.arrayOfArchivedNotes.count
    }
    
    //populate views of collection view
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: "archiveCell", for: indexPath) as! myArchiveCell
        cell = myArchiveCell.setArchiveCellParameters(GetData.arrayOfArchivedNotes[indexPath.row],cell) as! myArchiveCell
        return cell
    }
    
    //do on selecting a note
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        dataAndLayoutHandler.saveDetailsOfNoteToBeEdited(indexPath.row)
        performSegue(withIdentifier: "editArchivedNote", sender: self)
        
    }
    
    func setCellParameters(_ cell:UICollectionViewCell,_ index:Int) -> UICollectionViewCell{
        cell.backgroundColor = UIColor.gray
        cell.layer.cornerRadius = 10
        return cell
    }
    
}
