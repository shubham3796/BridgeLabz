//
//  ReminderViewController.swift
//  loginRegisterPortal
//
//  Created by admin on 21/11/19.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit
import CoreData

class ReminderViewController: UIViewController, /*UICollectionViewDataSource,*/ UICollectionViewDelegate {
//    var reminderTitle = [String]()
//    var reminderDateTime = [String]()
//
//    //    var reminderIndexArray = [Int]()
//
//    @IBOutlet weak var reminderCollectionView: UICollectionView!
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return reminderTitle.count
//    }
//
//    @IBAction func backToMenuContent(_ sender: UIButton) {
//        performSegue(withIdentifier: "backtomenucontent", sender: self)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let main = UIStoryboard(name:"Main", bundle: nil)
//        let first = main.instantiateViewController(withIdentifier: "reminderOpen") as! deleteReminderViewController
//        first.remindeTitle = reminderTitle[indexPath.item]
//        first.reminderIndex = indexPath.item
//        first.remindeText = reminderDateTime[indexPath.item]
//        self.present(first, animated: true, completion: nil)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "remindCell", for: indexPath) as! ReminderCell
//        cell.reminderNote.text = reminderTitle[indexPath.row]
//        cell.reminderTime.text = reminderDateTime[indexPath.row]
//        cell.layer.borderWidth = 3
//        cell.layer.borderColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
//        return cell
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: ((self.view.frame.size.width/4)), height: 50)
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        loadCollectionView()
//        loadReminderCoreData()
//    }
//
//    func loadCollectionView() {
//        let itemSize = UIScreen.main.bounds.width
//        let layout = UICollectionViewFlowLayout()
//        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 30, right: 0)
//
//        if traitCollection.horizontalSizeClass == .compact  && traitCollection.verticalSizeClass == .regular {
//            layout.itemSize = CGSize(width: itemSize - 40, height: itemSize/4)
//        }
//
//        if traitCollection.horizontalSizeClass == .regular && traitCollection.verticalSizeClass == .compact {
//            layout.itemSize = CGSize(width: itemSize/6, height: itemSize/6)
//        }
//
//        if traitCollection.horizontalSizeClass == .regular && traitCollection.verticalSizeClass == .regular {
//            layout.itemSize = CGSize(width: itemSize/3, height: itemSize/7)
//        }
//
//        layout.minimumInteritemSpacing = 10
//        layout.minimumLineSpacing = 10
//        reminderCollectionView.collectionViewLayout = layout
//    }
//
//    func loadReminderCoreData() {
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        let context = appDelegate.persistentContainer.viewContext
//        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Reminder")
//        request.returnsObjectsAsFaults = false
//
//        do {
//            let result = try context.fetch(request)
//            for data in result as! [NSManagedObject] {
//                var reminderDate = data.value(forKey: "date") as! String
//                let reminderNoteTitle = data.value(forKey: "title") as! String
//                let reminderTime = data.value(forKey: "time") as! String
//                //                let reminderNumber = data.value(forKey: "reminderno") as! String
//
//                reminderDate.append(" ")
//                reminderDate.append(reminderTime)
//
//                reminderTitle.append(reminderNoteTitle)
//                reminderDateTime.append(reminderDate)
//
//            }
//        } catch {
//            print("Failed")
//        }
//    }
    
    
    
    
    /////////////////////////////////////////////
//
}


    

