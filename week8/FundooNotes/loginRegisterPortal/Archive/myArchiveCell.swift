
import Foundation
import UIKit

class myArchiveCell: UICollectionViewCell {
    
    @IBOutlet weak var archiveTitle: UILabel!
    @IBOutlet weak var archiveTextView: UITextView!
    @IBOutlet weak var markImportantLabel: UILabel!
    @IBOutlet weak var reminderLabel: UILabel!
    
    static func setArchiveCellParameters(_ presentNote:oneNote,_ cell:myArchiveCell) -> UICollectionViewCell{
        
        cell.archiveTextView.text = presentNote.note
        cell.archiveTitle.text = presentNote.oneTitle
        cell.reminderLabel.text = presentNote.reminderDateTimeInfo
        cell.reminderLabel.textColor = UIColor.black
        if presentNote.important {
            cell.markImportantLabel.text = "✭"
        }
        else {
            cell.markImportantLabel.text = ""
        }
        let cellColorIndex = presentNote.color //an integer value
        cell.backgroundColor = DashboardControllerDelegate.arrayOfColors[cellColorIndex! - 1]
        cell.layer.cornerRadius = 10
        return cell
    }
    
}


