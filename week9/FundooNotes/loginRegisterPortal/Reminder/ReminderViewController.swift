//
//  ReminderViewController.swift
//  loginRegisterPortal
//
//  Created by admin on 21/11/19.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit
import CoreData

class ReminderViewController: UIViewController {
    var reminderViewControllerDelegate = ReminderViewControllerDelegate()
    
    @IBOutlet weak var reminderCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reminderViewControllerDelegate.retrieveData()
        let itemsize = UIScreen.main.bounds.width/2 - 17
        reminderCollectionView.collectionViewLayout = reminderViewControllerDelegate.setLayoutOfCollectionView(itemsize)
    }
    
    

    func setCellParameters(_ cell:UICollectionViewCell,_ index:Int) -> UICollectionViewCell{
        cell.backgroundColor = UIColor.gray
        cell.layer.cornerRadius = 10
        return cell
    }
    
    @IBAction func backButtonPress(_ sender: UIButton) {
                GetData.shouldRetrieveData = false
                GetData.indexOfNoteToBeEdited = 1000
                performSegue(withIdentifier: "backFromReminders", sender: self)

    }
    

    
    /////////////////////////////////////////////
//
}


    

