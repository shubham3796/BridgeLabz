//
//  EditArchivedNoteModel.swift
//  loginRegisterPortal
//
//  Created by admin on 26/11/19.
//  Copyright © 2019 admin. All rights reserved.
//

import Foundation
class EditArchivedNoteModel {
    var noteEditor = EditNoteModel()
    
    func saveArrayOfArchivedNoteIndices(){
        var i=0
        if  GetData.arrayOfArchivedNoteIndices.count == GetData.arrayOfArchivedNotes.count{
            while i<GetData.arrayOfArchivedNotes.count{
                GetData.arrayOfArchivedNoteIndices[i] = GetData.arrayOfArchivedNotes[i].index
                i+=1
            }
        }
        else {
            while i<GetData.arrayOfArchivedNotes.count{
                GetData.arrayOfArchivedNoteIndices.append(GetData.arrayOfArchivedNotes[i].index)
                i+=1
            }
        }
        noteEditor.writeToUserDefaultAnArrayOfInt(GetData.arrayOfArchivedNoteIndices,"SavedArrayOfArchivedNoteIndices")
    }
    
    
    func addToArrayOfArchivedNoteIndices(_ numberOfArchivedNotes:Int){
        GetData.arrayOfArchivedNoteIndices = noteEditor.readFromUserDefaultAnArrayOfInt("SavedArrayOfArchivedNoteIndices")
        GetData.arrayOfArchivedNoteIndices.append(numberOfArchivedNotes)
        noteEditor.writeToUserDefaultAnArrayOfInt(GetData.arrayOfArchivedNoteIndices,"SavedArrayOfArchivedNoteIndices")
    }
    

    func removeFromArrayOfArchivedNoteIndices(){
        GetData.arrayOfArchivedNoteIndices = noteEditor.readFromUserDefaultAnArrayOfInt("SavedArrayOfArchivedNoteIndices")
        GetData.arrayOfArchivedNoteIndices.remove(at: GetData.indexOfNoteToBeEdited)
        noteEditor.writeToUserDefaultAnArrayOfInt(GetData.arrayOfArchivedNoteIndices,"SavedArrayOfArchivedNoteIndices")
    }
    
    func modifyArchivedArrayOfNotes(){
        GetData.arrayOfArchivedNoteIndices = noteEditor.readFromUserDefaultAnArrayOfInt("SavedArrayOfArchivedNoteIndices")
        var j=0
        while j < GetData.arrayOfArchivedNoteIndices.count {
            if GetData.arrayOfArchivedNoteIndices[j] > GetData.positionOfNoteToBeEdited  {
                GetData.arrayOfArchivedNoteIndices[j]-=1
            }
            if GetData.arrayOfArchivedNotes[j].index > GetData.positionOfNoteToBeEdited  {
                GetData.arrayOfArchivedNotes[j].index-=1
                
            }
            j+=1
        }
        GetData.indexOfNoteToBeEdited = 1000 // this means that array of note indices has been updated after deletion
        noteEditor.writeToUserDefaultAnArrayOfInt(GetData.arrayOfArchivedNoteIndices,"SavedArrayOfArchivedNoteIndices")
    }
    
}

