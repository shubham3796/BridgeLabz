import UIKit
import Alamofire

struct archiveNotes : Encodable {
    var isArchived: Bool
    var noteIdList: [String]
}

struct Reminder : Encodable {
    var noteIdList: [String]
    var reminder: [String]
}

extension EditNote  {
    
    struct DeleteNotes : Encodable {
        var isDeleted: Bool
        var noteIdList: [String]
    }
    
    func archiveNote(){
   
        archived = !archived
        var numberOfArchivedNotes = GetData.arrayOfArchivedNotes.count
        numberOfArchivedNotes += 1
       
        print("EditNoteDelegate -> 24")
        GetData.printDetails()
        GetData.arrayOfArchivedNotes.append(oneNote(noteTitle.text!,note.text,GetData.colorOfNoteToBeEdited,numberOfArchivedNotes,archived,markedImportant,reminderInfo))
      
        print("EditNoteDelegate -> 28")
        GetData.printDetails()
        
        index = numberOfArchivedNotes-1
        
        EditNoteModel.updateOrDeleteNoteOfCoreData(index,deleteNoteFlag, noteTitle.text!,note.text,archived,markedImportant,reminderInfo)
      
        archivedNoteEditor.addToArrayOfArchivedNoteIndices(numberOfArchivedNotes)
       
        print("EditNoteDelegate -> 37")
        GetData.printDetails()
        
        GetData.localArrayOfNotes.remove(at: GetData.indexOfNoteToBeEdited)
      
        print("EditNoteDelegate -> 42")
        GetData.printDetails()
        
        noteEditor.removeFromArrayOfIndices()
        
        print("EditNoteDelegate -> 47")
        GetData.printDetails()
        
        noteEditor.modifyLocalArrayOfNotes()
        
        print("EditNoteDelegate -> 52")
        GetData.printDetails()
        
        GetData.shouldRetrieveData = true
    }
    
    func archiveNoteRemotely(noteIds: [String],toArchive: Bool) {
        let archiveNote = archiveNotes(isArchived: toArchive, noteIdList: noteIds)
        let access_token: String = UserDefaults.standard.string(forKey: "accessToken")!
        
        let url: String = WebServicesCommonData.archiveNoteURL + "?access_token=" + access_token
        
        AF.request(
            url,
            method: .post,
            parameters: archiveNote,
            encoder: JSONParameterEncoder.default
            )
            .validate(contentType: ["application/json"])
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                switch response.result {
                case .success:
                    print("Note archived remotely.")
                case let .failure(error):
                    print("ERROR : Note archive remotely FAILED.")
                }
        }
    }
    
    func unArchiveTheArchivedNote(){
        archived = !archived
        var numberOfNotes = GetData.localArrayOfNotes.count
        numberOfNotes += 1
        GetData.localArrayOfNotes.append(oneNote(noteTitle.text!,note.text,GetData.colorOfNoteToBeEdited,numberOfNotes,archived,markedImportant,reminderInfo))
        
        index = numberOfNotes-1
        
        EditNoteModel.updateOrDeleteNoteOfCoreData(index,deleteNoteFlag, noteTitle.text!,note.text,archived,markedImportant,reminderInfo)
        
        noteEditor.addToArrayOfIndices(numberOfNotes)
        
        GetData.arrayOfArchivedNotes.remove(at: GetData.indexOfNoteToBeEdited)
        
        archivedNoteEditor.removeFromArrayOfArchivedNoteIndices()
        
        noteEditor.sortLocalArrayOfNotes()
        
        GetData.openArchive = true
        GetData.shouldRetrieveData = false
    }
    
    func addReminderRemotely(noteIds: [String],reminderDate: [String]) {
        let reminder = Reminder(noteIdList: noteIds, reminder: reminderDate)
        let access_token: String = UserDefaults.standard.string(forKey: "accessToken")!
        
        let url: String = WebServicesCommonData.addUpdateReminderURL + "?access_token=" + access_token
        
        AF.request(
            url,
            method: .post,
            parameters: reminder,
            encoder: JSONParameterEncoder.default
            )
            .validate(contentType: ["application/json"])
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                switch response.result {
                case .success:
                    print("Reminder added/updated remotely.")
                case .failure(_):
                    print("ERROR : Adding remote reminder FAILED.")
                }
        }
    }
    
    func deleteRemoteNote(noteId:String) {
        let deleteNote = DeleteNotes(isDeleted: true, noteIdList: ["\(noteId)"])
        
            let access_token: String = UserDefaults.standard.string(forKey: "accessToken")!
            let url: String = WebServicesCommonData.deleteForeverNoteURL + "?access_token=" + access_token
    
            AF.request(
                url,
                method: .post,
                parameters: deleteNote,
                encoder: JSONParameterEncoder.default
                )
                .validate(contentType: ["application/json"])
                .validate(statusCode: 200..<300)
                .responseJSON { response in
                    switch response.result {
                    case .success:
                        print("Remote note deleted")
                    case let .failure(error):
                        print(error)
                        print("************** Remote note deletion failed ****************")
                    }
            }
        }

}
