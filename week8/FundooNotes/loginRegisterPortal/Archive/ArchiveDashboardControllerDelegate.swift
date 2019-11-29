import UIKit
import CoreData


class ArchiveDashboardControllerDelegate: UIViewController,UICollectionViewDelegate {
    static var arrayOfColors = CommonUIController.arrayOfColors
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    func saveDetailsOfNoteToBeEdited(_ index: Int){
        GetData.titleOfNoteToBeEdited = GetData.arrayOfArchivedNotes[index].oneTitle!
        GetData.textOfNoteToBeEdited = GetData.arrayOfArchivedNotes[index].note
        GetData.indexOfNoteToBeEdited = index
        GetData.positionOfNoteToBeEdited = GetData.arrayOfArchivedNotes[index].index
        GetData.archiveStatusOfNoteToBeEdited = GetData.arrayOfArchivedNotes[index].archived
        GetData.importantStatusOfNoteToBeEdited = GetData.arrayOfArchivedNotes[index].important
    }
    
    func setLayoutOfCollectionView(_ itemsize:CGFloat) -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top:20,left:12,bottom: 10, right: 12)
        layout.itemSize = CGSize(width: itemsize, height: itemsize)
        layout.minimumInteritemSpacing = 4
        layout.minimumLineSpacing = 8
        return layout
    }
    
    func retrieveData(){
        GetData.arrayOfArchivedNotes = [oneNote]()
        //retrieve the saved(as user default) array of archived note indices
        GetData.arrayOfArchivedNoteIndices = UserDefaults.standard.object(forKey: "SavedArrayOfArchivedNoteIndices") as? [Int] ?? [Int]()
        
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
                print("\(title)             \(text)")
                let archived = data.value(forKey: "archived") as! Bool
                let markedImportant = data.value(forKey: "important") as! Bool
                var foundFlag=false
                if archived{
                    if let color = UIColor.color(data: myColorData) {
                        var i=0
                        while i < ArchiveDashboardControllerDelegate.arrayOfColors.count && foundFlag == false {
                            if color == ArchiveDashboardControllerDelegate.arrayOfColors[i]{
                                GetData.arrayOfArchivedNotes.append(oneNote(title,text,i+1,index,archived,markedImportant,""))
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
