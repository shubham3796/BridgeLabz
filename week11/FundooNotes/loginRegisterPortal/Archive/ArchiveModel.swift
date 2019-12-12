
import UIKit
import CoreData

class ArchiveModel{
   static func saveDetailsOfNoteToBeEdited(_ index: Int){
        GetData.titleOfNoteToBeEdited = GetData.arrayOfArchivedNotes[index].oneTitle!
        GetData.textOfNoteToBeEdited = GetData.arrayOfArchivedNotes[index].note
        GetData.indexOfNoteToBeEdited = index
        GetData.positionOfNoteToBeEdited = GetData.arrayOfArchivedNotes[index].index
        GetData.archiveStatusOfNoteToBeEdited = GetData.arrayOfArchivedNotes[index].archived
        GetData.importantStatusOfNoteToBeEdited = GetData.arrayOfArchivedNotes[index].important
        GetData.reminderInfoOfNoteToBeEdited = GetData.arrayOfArchivedNotes[index].reminderDateTimeInfo
    }
    
    func retrieveArchiveNotes(completion: @escaping ((_ noteList: [oneNote]) -> Void)){
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
                let archived = data.value(forKey: "archived") as! Bool
                let markedImportant = data.value(forKey: "important") as! Bool
                let reminderInfo = data.value(forKey: "reminderInfo") as! String
                var foundFlag=false
                let color2 = UIColor.color(data: myColorData)

                if archived{
                        var i=0
                        
                        while i < CommonUIController.arrayOfColors.count && foundFlag == false {
                            let color1 = CommonUIController.arrayOfColors[i]
                            if UIColor().compareUIColors(color1,color2!){
                                
                                let indexx = GetData.arrayOfArchivedNotes.count + 1
                                GetData.arrayOfArchivedNotes.append(oneNote(title,text,i+1,indexx,archived,markedImportant,reminderInfo))
                                
                                foundFlag = true
                                index += 1
                            }
                            i+=1
                        }
                }
            }
            GetData.shouldRetrieveArchiveNotes = false
            completion(GetData.arrayOfArchivedNotes)
    }
    catch {
            print("Failed")
        }
    }
}
