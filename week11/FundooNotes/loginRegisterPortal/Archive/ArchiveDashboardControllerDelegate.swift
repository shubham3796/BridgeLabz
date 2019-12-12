import UIKit
import CoreData


class ArchiveDashboardControllerDelegate: UIViewController,UICollectionViewDelegate {
    static var arrayOfColors = CommonUIController.arrayOfColors
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func setLayoutOfCollectionView(_ itemsize:CGFloat) -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top:20,left:12,bottom: 10, right: 12)
        layout.itemSize = CGSize(width: itemsize, height: itemsize)
        layout.minimumInteritemSpacing = 4
        layout.minimumLineSpacing = 8
        return layout
    }
    
    
}
