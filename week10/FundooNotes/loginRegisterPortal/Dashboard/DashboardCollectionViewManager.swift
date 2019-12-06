//
//  DashboardCollectionViewManager.swift
//  loginRegisterPortal
//
//  Created by admin on 26/11/19.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit


// COLLECTION VIEW FUNCTIONALITIES
extension DashboardController : UICollectionViewDataSource, UICollectionViewDelegate{
    //number of views in collection view
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  filteredArrayOfNotes.count
    }
    
    //populate views of collection view
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! myCell
        cell = myCell.setCellParameters(filteredArrayOfNotes[indexPath.row],cell) as! myCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let item = GetData.localArrayOfNotes.remove(at: sourceIndexPath.item)
        GetData.localArrayOfNotes.insert(item,at: destinationIndexPath.item)
        
        DashBoardModel.saveParametersAfterMovingCells()
        filteredArrayOfNotes = GetData.localArrayOfNotes
        myCollectionView.reloadData()
    }
    
    //do on selecting a note
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        DashBoardModel.saveDetailsOfNoteToBeEdited(indexPath.row)
        performSegue(withIdentifier: "editNote", sender: self)
    }
    
    //Move cells on being long pressed
    @objc func handleLongGesture(gesture: UILongPressGestureRecognizer){
        switch(gesture.state){
        case .began:
            guard let selectedIndexPath = myCollectionView.indexPathForItem(at: gesture.location(in: myCollectionView)) else {
                break
            }
            myCollectionView.beginInteractiveMovementForItem(at: selectedIndexPath)
        case .changed:
            myCollectionView.updateInteractiveMovementTargetPosition(gesture.location(in: gesture.view))
        case .ended:
            myCollectionView.endInteractiveMovement()
        default:
            myCollectionView.cancelInteractiveMovement()
        }
    }
    
}
//class DashboardCollectionViewManager: UIViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//    }
//
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//}
