
import UIKit
import CoreData

class DashboardControllerDelegate: UIViewController,UICollectionViewDelegate {

    static var arrayOfColors = CommonUIController.arrayOfColors
    private let notificationCenter = NotificationCenter.default
   // var date:Date
    override func viewDidLoad() {
        super.viewDidLoad()
    }
//    init(){
//        date = Date()
//    }
    
//    required init?(coder aDecoder: NSCoder) {
//        date = Date()
//        fatalError("init(coder:) has not been implemented")
//    }
    
     func retrieveData(){
       // DashBoardModel.clearAllNotesBeforeRetrieving()
//        date = Date()
      //  print("25 -> \(date)")
        GetData.localArrayOfNotes = [oneNote]()
        GetData.arrayOfNoteIndices = UserDefaults.standard.object(forKey: "SavedArrayOfIndices") as? [Int] ?? [Int]()
        
        if GetData.noteJustArchived {
            DashBoardModel.modifyLocalArrayOfNotes()
            DashBoardModel.sortLocalArrayOfNotes()
            GetData.noteJustArchived = false
        }
        else {
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
                    print("175 -> \(title)             \(text)")
                    let archived = data.value(forKey: "archived") as! Bool
                    let important = data.value(forKey: "important") as! Bool
                    let reminderInfo = data.value(forKey: "reminderInfo") as! String
                    let reminderDate = data.value(forKey: "reminderDate") as! Date
                    
                    var foundFlag=false
                    if !archived{
                        if let color = UIColor.color(data: myColorData) {
                            var i=0
                            while i < DashboardControllerDelegate.arrayOfColors.count && foundFlag == false {
                                if color == DashboardControllerDelegate.arrayOfColors[i]{
                                    GetData.localArrayOfNotes.append(oneNote(title,text,i+1,index,archived,important,reminderInfo))
                                    foundFlag = true
                                    index += 1
                                }
                                i+=1
                            }
                        }
                    }
                }
                if GetData.indexOfNoteToBeEdited > 990 {
                    DashBoardModel.sortLocalArrayOfNotes()
                }
                else if GetData.noteJustAdded == true {
                    print("60")
                }
                else {
                    DashBoardModel.modifyLocalArrayOfNotes()
                    DashBoardModel.sortLocalArrayOfNotes()
                }
                GetData.shouldRetrieveData = false
                GetData.noteJustAdded = false
            } catch {
                print("Failed")
            }
        }
        
    }
    
    func saveDetailsOfNoteToBeEdited(_ index: Int){
        GetData.titleOfNoteToBeEdited = GetData.localArrayOfNotes[index].oneTitle!
        GetData.textOfNoteToBeEdited = GetData.localArrayOfNotes[index].note
        GetData.indexOfNoteToBeEdited = index
        GetData.positionOfNoteToBeEdited = GetData.localArrayOfNotes[index].index
        GetData.archiveStatusOfNoteToBeEdited = false
        GetData.importantStatusOfNoteToBeEdited = GetData.localArrayOfNotes[index].important
        GetData.reminderInfoOfNoteToBeEdited = GetData.localArrayOfNotes[index].reminderDateTimeInfo
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
