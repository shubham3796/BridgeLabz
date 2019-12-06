
import UIKit

class myCell: UICollectionViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var myTextView: UITextView!
    @IBOutlet weak var markImportantLabel: UILabel!
    @IBOutlet weak var reminderLabel: UILabel!
    
    static func setCellParameters(_ presentNote:oneNote,_ cell:myCell) -> UICollectionViewCell{
        cell.myTextView.text = presentNote.note
        cell.title.text = presentNote.oneTitle
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
