
import UIKit

extension ReminderViewController :   UICollectionViewDelegate, UICollectionViewDataSource {
    
    //number of views in collection view
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  filteredReminderNotes.count
    }
    
    //populate views of collection view
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reminderCell", for: indexPath) as! ReminderCollectionViewCell
        cell = ReminderCollectionViewCell.setReminderCellParameters(filteredReminderNotes[indexPath.row],cell) as! ReminderCollectionViewCell
        return cell
    }
    
    
    //do on selecting a note
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        ReminderModel.saveDetailsOfNoteToBeEdited(indexPath.row)
        
        performSegue(withIdentifier: "editReminderedNote", sender: self)
        
    }
    
    
}

