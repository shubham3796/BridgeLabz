
import Foundation

class DashBoardModel {
    
    static func clearArrayOfIndices(){
        GetData.arrayOfNoteIndices = []
        GetData.arrayOfArchivedNoteIndices = []
        GetData.arrayOfReminderedNoteIndices = []
        UserDefaults.standard.set(GetData.arrayOfNoteIndices, forKey: "SavedArrayOfIndices")
        UserDefaults.standard.synchronize()
        
        UserDefaults.standard.set(GetData.arrayOfNoteIndices, forKey: "SavedArrayOfArchivedNoteIndices")
        UserDefaults.standard.synchronize()
        
        UserDefaults.standard.set(GetData.arrayOfReminderedNoteIndices, forKey: "SavedArrayOfArchivedNoteIndices")
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
        if  GetData.arrayOfNoteIndices.count == GetData.localArrayOfNotes.count{
            while i<GetData.localArrayOfNotes.count{
                GetData.arrayOfNoteIndices[i] = GetData.localArrayOfNotes[i].index
                i+=1
            }
        }
        else {
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
        while i<GetData.localArrayOfNotes.count {
            if GetData.arrayOfNoteIndices.count == 0 {
                DashBoardModel.saveArrayOfIndices()
            }
            if GetData.indexOfNoteToBeEdited < 900 && (GetData.arrayOfNoteIndices[i] > GetData.arrayOfNoteIndices[GetData.indexOfNoteToBeEdited]){
                GetData.arrayOfNoteIndices[i] -= 1
            }
            print("53 -> i = \(i) , arrayOfNoteIndices -> \(GetData.arrayOfNoteIndices) ")
            
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

}
