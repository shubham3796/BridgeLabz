//
//  EditNoteDelegate.swift
//  loginRegisterPortal
//
//  Created by admin on 27/11/19.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit
import Alamofire

extension EditNote  {
    
    struct DeleteNotes : Encodable {
        var isDeleted: Bool
        var noteIdList: [String]
    }
    
    func archiveNote(){
        print("14 - EditNoteDelegate -> \(GetData.arrayOfNoteIndices)")
        archived = !archived
        var numberOfArchivedNotes = GetData.arrayOfArchivedNoteIndices.count
        numberOfArchivedNotes += 1
        GetData.arrayOfArchivedNotes.append(oneNote(noteTitle.text!,note.text,GetData.colorOfNoteToBeEdited,numberOfArchivedNotes,archived,markedImportant,reminderInfo))
        
        index = numberOfArchivedNotes-1
        
        EditNoteModel.updateOrDeleteNoteOfCoreData(index,deleteNoteFlag, noteTitle.text!,note.text,archived,markedImportant,reminderInfo)
        
        archivedNoteEditor.addToArrayOfArchivedNoteIndices(numberOfArchivedNotes)
        
        GetData.localArrayOfNotes.remove(at: GetData.indexOfNoteToBeEdited)
        
        noteEditor.removeFromArrayOfIndices()
        
        noteEditor.modifyLocalArrayOfNotes()
        
        GetData.shouldRetrieveData = true
        print("33 - EditNoteDelegate -> \(GetData.arrayOfNoteIndices)")
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
    
    func deleteRemoteNote(noteId:String) {
        let deleteNote = DeleteNotes(isDeleted: true, noteIdList: ["\(noteId)"])
        print("")
        print("66-> EditNoteDelegate -> \(noteId)")
        print("")
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
