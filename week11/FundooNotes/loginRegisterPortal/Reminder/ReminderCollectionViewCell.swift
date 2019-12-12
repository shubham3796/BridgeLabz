//
//  ReminderCollectionViewCell.swift
//  loginRegisterPortal
//
//  Created by admin on 28/11/19.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit
import UIKit

class ReminderCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var reminderTitle: UILabel!
    @IBOutlet weak var reminderTextView: UITextView!
    @IBOutlet weak var markImportantLabel: UILabel!
    @IBOutlet weak var reminderLabel: UILabel!
    
    static func setReminderCellParameters(_ presentNote:oneNote,_ cell:ReminderCollectionViewCell) -> UICollectionViewCell{
        
        cell.reminderTextView.text = presentNote.note
        cell.reminderTitle.text = presentNote.oneTitle
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
