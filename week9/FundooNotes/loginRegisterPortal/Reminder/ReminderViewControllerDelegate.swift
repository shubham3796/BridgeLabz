//
//  ReminderViewControllerDelegate.swift
//  loginRegisterPortal
//
//  Created by admin on 28/11/19.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit
import CoreData

class ReminderViewControllerDelegate: UIViewController,UICollectionViewDelegate {
    static var arrayOfColors = CommonUIController.arrayOfColors
    
    func setLayoutOfCollectionView(_ itemsize:CGFloat) -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top:20,left:12,bottom: 10, right: 12)
        layout.itemSize = CGSize(width: itemsize, height: itemsize)
        layout.minimumInteritemSpacing = 4
        layout.minimumLineSpacing = 8
        return layout
    }
    
    func saveDetailsOfNoteToBeEdited(_ index: Int){
        GetData.titleOfNoteToBeEdited = GetData.arrayOfReminderedNotes[index].oneTitle!
        GetData.textOfNoteToBeEdited = GetData.arrayOfReminderedNotes[index].note
        GetData.indexOfNoteToBeEdited = index
        GetData.positionOfNoteToBeEdited = GetData.arrayOfReminderedNotes[index].index
        GetData.archiveStatusOfNoteToBeEdited = GetData.arrayOfReminderedNotes[index].archived
        GetData.importantStatusOfNoteToBeEdited = GetData.arrayOfReminderedNotes[index].important
        GetData.reminderInfoOfNoteToBeEdited = GetData.arrayOfReminderedNotes[index].reminderDateTimeInfo
    }
    
    func retrieveData(){
        GetData.arrayOfReminderedNotes = [oneNote]()
        //retrieve the saved(as user default) array of archived note indices
        GetData.arrayOfReminderedNoteIndices = UserDefaults.standard.object(forKey: "SavedArrayOfReminderedNoteIndices") as? [Int] ?? [Int]()
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return}
        var index = 1
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        do{
            let result = try managedContext.fetch(fetchRequest)
            for data in result as! [NSManagedObject] {
                let title = data.value(forKey: "title") as! String
                let text = data.value(forKey: "noteText") as! String
                let myColorData = data.value(forKey: "color") as! Data
                let archived = data.value(forKey: "archived") as! Bool
                let markedImportant = data.value(forKey: "important") as! Bool
                let reminderInfo = data.value(forKey: "reminderInfo") as! String
                var foundFlag=false
                if reminderInfo != ""{
                    if let color = UIColor.color(data: myColorData) {
                        var i=0
                        while i < ArchiveDashboardControllerDelegate.arrayOfColors.count && foundFlag == false {
                            if color == ReminderViewControllerDelegate.arrayOfColors[i]{
                                GetData.arrayOfReminderedNotes.append(oneNote(title,text,i+1,index,archived,markedImportant,reminderInfo))
                                foundFlag = true
                                index += 1
                            }
                            i+=1
                        }
                    }
                }
            }
            
        } catch {
            print("Failed")
        }
    }
}
