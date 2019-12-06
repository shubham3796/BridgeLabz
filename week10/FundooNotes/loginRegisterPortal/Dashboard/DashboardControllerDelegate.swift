
import UIKit
import CoreData

class DashboardControllerDelegate: UIViewController,UICollectionViewDelegate {

    var dashBoardModel = DashBoardModel()
    static var arrayOfColors = CommonUIController.arrayOfColors
    private let notificationCenter = NotificationCenter.default
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setLayoutOfCollectionView(_ width:CGFloat){
        let layout = UICollectionViewFlowLayout()
        
        if GetData.viewLayout == 1{//for grid view
            let itemsize = width/2 - 17
            layout.sectionInset = UIEdgeInsets(top:20,left:12,bottom: 10, right: 12)
            layout.itemSize = CGSize(width: itemsize, height: itemsize)
            layout.minimumInteritemSpacing = 4
            layout.minimumLineSpacing = 8
        }
        else {//for list view
            let itemsize = width - 24
            layout.sectionInset = UIEdgeInsets(top:20,left:12,bottom: 10, right: 12)
            layout.itemSize = CGSize(width: itemsize, height: itemsize/2)
            layout.minimumInteritemSpacing = 4
            layout.minimumLineSpacing = 8
        }
        NotificationCenter.default.post(name: Notification.Name(rawValue: "dashboardCollectionViewLayout"), object: nil, userInfo: ["layout":layout])
    }
    
}
