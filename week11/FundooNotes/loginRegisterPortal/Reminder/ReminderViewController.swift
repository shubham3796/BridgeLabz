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
    var reminderModel = ReminderModel()
    var filteredReminderNotes = [oneNote]()
    
    @IBOutlet weak var reminderCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //reminderViewControllerDelegate.retrieveData()
        
        if GetData.shouldRetrieveReminderedNotes{
            if Connectivity.isConnectedToInternet{
                reminderModel.retrieveReminderedNotesFromCoreData{ [weak self] (noteList: [oneNote]) in
                    self?.saveReminderedNotesFromCoreData(noteList: noteList)
            }
            }
            else {
                reminderModel.getReminderedNotesFromServer{ [weak self] (noteList: [oneNote]) in
                    self?.saveReminderedNotesFromWeb(noteList: noteList)
                }
            }
        
        let itemsize = UIScreen.main.bounds.width/2 - 17
        reminderCollectionView.collectionViewLayout = reminderViewControllerDelegate.setLayoutOfCollectionView(itemsize)
    }
    }
    
    @IBAction func backButtonPress(_ sender: UIButton) {
        GetData.shouldRetrieveData = false
        GetData.indexOfNoteToBeEdited = 1000
        performSegue(withIdentifier: "backFromReminders", sender: self)
        
    }
    
    private func saveReminderedNotesFromCoreData(noteList: [oneNote]){
        filteredReminderNotes = noteList
        reminderCollectionView.reloadData()
    }
        
    private func saveReminderedNotesFromWeb(noteList: [oneNote]){
        filteredReminderNotes = noteList
        reminderCollectionView.reloadData()
    }
    
    /////////////////////////////////////////////
    //
}




