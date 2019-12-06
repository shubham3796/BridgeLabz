
import Foundation
import CoreData
import UIKit

class DashBoardModel {
    
    static func clearArrayOfIndices(){
        GetData.arrayOfNoteIndices = []
        GetData.arrayOfArchivedNoteIndices = []
        GetData.arrayOfReminderedNoteIndices = []
        UserDefaults.standard.set(GetData.arrayOfNoteIndices, forKey: "SavedArrayOfIndices")
        UserDefaults.standard.synchronize()
        
        UserDefaults.standard.set(GetData.arrayOfNoteIndices, forKey: "SavedArrayOfArchivedNoteIndices")
        UserDefaults.standard.synchronize()
        
        UserDefaults.standard.set(GetData.arrayOfReminderedNoteIndices, forKey: "SavedArrayOfReminderedNoteIndices")
        UserDefaults.standard.synchronize()
        
        GetData.localArrayOfNotes = [oneNote]()
        GetData.arrayOfArchivedNotes = [oneNote]()
        GetData.arrayOfReminderedNotes = [oneNote]()
    }
    
    static func clearAllNotesBeforeRetrieving(){
        CoreDataController.deleteWholeCoreData()
        DashBoardModel.clearArrayOfIndices()
    }
    
    static func saveArrayOfIndices(){
        var i=0
        if  GetData.arrayOfNoteIndices.count == GetData.localArrayOfNotes.count  {
            while i<GetData.localArrayOfNotes.count{
                GetData.arrayOfNoteIndices[i] = GetData.localArrayOfNotes[i].index
                i+=1
            }
        }
        else {
            GetData.arrayOfNoteIndices = []
            while i<GetData.localArrayOfNotes.count{
                GetData.arrayOfNoteIndices.append(GetData.localArrayOfNotes[i].index)
                i+=1
            }
        }
        UserDefaults.standard.set(GetData.arrayOfNoteIndices, forKey: "SavedArrayOfIndices")
        UserDefaults.standard.synchronize()
    }
    
    static func sortLocalArrayOfNotes() {
        var i=0
        var sortedArray = [oneNote]()
        GetData.arrayOfNoteIndices = UserDefaults.standard.object(forKey: "SavedArrayOfIndices") as? [Int] ?? [Int]()
        print("DashboardModel -> 53 -> arrayOfNoteIndices -> \(GetData.arrayOfNoteIndices) ")
        print("DashboardModel -> 54 -> Here there are \(GetData.localArrayOfNotes.count) notes in localArrayOfNotes ")
        while i<GetData.localArrayOfNotes.count {
            if GetData.arrayOfNoteIndices.count == 0 {
                DashBoardModel.saveArrayOfIndices()
            }
            if GetData.indexOfNoteToBeEdited < 900 && (GetData.arrayOfNoteIndices[i] > GetData.arrayOfNoteIndices[GetData.indexOfNoteToBeEdited]){
                GetData.arrayOfNoteIndices[i] -= 1
            }
            print("DashboardModel -> 62 -> \(i)  \(GetData.arrayOfNoteIndices[i]) ")
            sortedArray.append(GetData.localArrayOfNotes[GetData.arrayOfNoteIndices[i]-1])
            i+=1
        }
        GetData.localArrayOfNotes = sortedArray
    }
    
    static func modifyLocalArrayOfNotes(){
        GetData.arrayOfNoteIndices = UserDefaults.standard.object(forKey: "SavedArrayOfIndices") as? [Int] ?? [Int]()
        var j=0
        while j < GetData.arrayOfNoteIndices.count {
            if GetData.arrayOfNoteIndices[j] > GetData.positionOfNoteToBeEdited  {
                GetData.arrayOfNoteIndices[j]-=1
            }
            if GetData.localArrayOfNotes[j].index > GetData.positionOfNoteToBeEdited  {
                GetData.localArrayOfNotes[j].index-=1
            }
            j+=1
        }
        GetData.indexOfNoteToBeEdited = 1000 // this means that array of note indices has been updated after deletion
        UserDefaults.standard.set(GetData.arrayOfNoteIndices, forKey: "SavedArrayOfIndices")
        UserDefaults.standard.synchronize()
    }
    
    static func saveParametersAfterMovingCells(){
        GetData.indexOfNoteToBeEdited = 1000
        GetData.noteJustArchived = false
        DashBoardModel.saveArrayOfIndices()
    }
    
    static func saveDetailsOfNoteToBeEdited(_ index: Int){
        GetData.titleOfNoteToBeEdited = GetData.localArrayOfNotes[index].oneTitle!
        GetData.textOfNoteToBeEdited = GetData.localArrayOfNotes[index].note
        GetData.indexOfNoteToBeEdited = index
        GetData.positionOfNoteToBeEdited = GetData.localArrayOfNotes[index].index
        GetData.archiveStatusOfNoteToBeEdited = false
        GetData.importantStatusOfNoteToBeEdited = GetData.localArrayOfNotes[index].important
        GetData.reminderInfoOfNoteToBeEdited = GetData.localArrayOfNotes[index].reminderDateTimeInfo
    }
    
    func retrieveNotesFromCoreData(){
        
        GetData.localArrayOfNotes = [oneNote]()
        GetData.arrayOfNoteIndices = UserDefaults.standard.object(forKey: "SavedArrayOfIndices") as? [Int] ?? [Int]()
        print("103 -> DashboardModel -> arrayOfNoteIndices -> \(GetData.arrayOfNoteIndices)")
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
                    let archived = data.value(forKey: "archived") as! Bool
                    let important = data.value(forKey: "important") as! Bool
                    let reminderInfo = data.value(forKey: "reminderInfo") as! String
                    _ = data.value(forKey: "reminderDate") as! Date
                    
                    var foundFlag=false
                
                        if let color = UIColor.color(data: myColorData) {
                            var i=0
                            while i < DashboardControllerDelegate.arrayOfColors.count && foundFlag == false {
                                if color == DashboardControllerDelegate.arrayOfColors[i]{
                                   
                                    if !archived {
                               let indexx = GetData.localArrayOfNotes.count + 1
                                        GetData.localArrayOfNotes.append(oneNote(title,text,i+1,indexx,archived,important,reminderInfo))
                                    }
                                    else {
                                       let indexx = GetData.arrayOfArchivedNotes.count + 1
                                        GetData.arrayOfArchivedNotes.append(oneNote(title,text,i+1,indexx,archived,important,reminderInfo))
                                    }
                                    if reminderInfo != ""{
                                       let indexx = GetData.arrayOfReminderedNotes.count + 1
                                        GetData.arrayOfReminderedNotes.append(oneNote(title,text,i+1,indexx,archived,important,reminderInfo))
                                    }
                                    foundFlag = true
                                    index += 1
                                }
                                i+=1
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

}
