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
    var reminderModel = ReminderModel()
    
    static var arrayOfColors = CommonUIController.arrayOfColors
    
    func setLayoutOfCollectionView(_ itemsize:CGFloat) -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top:20,left:12,bottom: 10, right: 12)
        layout.itemSize = CGSize(width: itemsize, height: itemsize)
        layout.minimumInteritemSpacing = 4
        layout.minimumLineSpacing = 8
        return layout
    }
    
}
