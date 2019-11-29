//
//  EditNoteDelegate.swift
//  loginRegisterPortal
//
//  Created by admin on 27/11/19.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit

extension EditNote  {
    
    func archiveNote(){
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
}
