import UIKit
import CoreData


class ReminderModel {
    
    static func saveDetailsOfNoteToBeEdited(_ index: Int){
        GetData.titleOfNoteToBeEdited = GetData.arrayOfReminderedNotes[index].oneTitle!
        GetData.textOfNoteToBeEdited = GetData.arrayOfReminderedNotes[index].note
        GetData.indexOfNoteToBeEdited = index
        GetData.positionOfNoteToBeEdited = GetData.arrayOfReminderedNotes[index].index
        GetData.archiveStatusOfNoteToBeEdited = GetData.arrayOfReminderedNotes[index].archived
        GetData.importantStatusOfNoteToBeEdited = GetData.arrayOfReminderedNotes[index].important
        GetData.reminderInfoOfNoteToBeEdited = GetData.arrayOfReminderedNotes[index].reminderDateTimeInfo
    }
    
    func retrieveReminderedNotesFromCoreData(completion: @escaping ((_ noteList: [oneNote]) -> Void)){
        
        GetData.arrayOfReminderedNotes = [oneNote]()
        
        //retrieve the saved(as user default) array of remindered note indices
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
                let color2 = UIColor.color(data: myColorData)
                
                if reminderInfo != ""{
                    var i=0
                    
                    while i < CommonUIController.arrayOfColors.count && foundFlag == false {
                        let color1 = CommonUIController.arrayOfColors[i]
                        if UIColor().compareUIColors(color1,color2!){
                            
                            let indexx = GetData.arrayOfReminderedNotes.count + 1
                            GetData.arrayOfReminderedNotes.append(oneNote(title,text,i+1,indexx,archived,markedImportant,reminderInfo))
                            
                            foundFlag = true
                            index += 1
                        }
                        i+=1
                    }
                }
            }
            GetData.shouldRetrieveReminderedNotes = false
            completion(GetData.arrayOfReminderedNotes)
        } catch {
            print("Failed")
        }
    }
}
