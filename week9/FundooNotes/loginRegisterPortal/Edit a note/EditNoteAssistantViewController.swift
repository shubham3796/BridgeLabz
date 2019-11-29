//
//  EditNoteAssistantViewController.swift
//  loginRegisterPortal
//
//  Created by admin on 22/11/19.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit
import CoreData

class EditNoteModel: UIViewController {

    //var noteEditor = EditNoteModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
     func readFromUserDefaultAnArrayOfInt(_ key:String) -> [Int]{
        let array = UserDefaults.standard.object(forKey: key) as? [Int] ?? [Int]()
        return array
    }
    
     func writeToUserDefaultAnArrayOfInt(_ array:[Int],_ key:String){
        UserDefaults.standard.set(array, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    func saveArrayOfNoteIndices(){
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
        writeToUserDefaultAnArrayOfInt(GetData.arrayOfNoteIndices,"SavedArrayOfIndices")
    }
    
    func addToArrayOfIndices(_ numberOfNotes:Int){
        GetData.arrayOfNoteIndices = readFromUserDefaultAnArrayOfInt("SavedArrayOfIndices")
        GetData.arrayOfNoteIndices.append(numberOfNotes)
        writeToUserDefaultAnArrayOfInt(GetData.arrayOfNoteIndices,"SavedArrayOfIndices")
    }
    
    func removeFromArrayOfIndices(){
        GetData.arrayOfNoteIndices = readFromUserDefaultAnArrayOfInt("SavedArrayOfIndices")
        
        GetData.arrayOfNoteIndices.remove(at: GetData.indexOfNoteToBeEdited)
        
        writeToUserDefaultAnArrayOfInt(GetData.arrayOfNoteIndices,"SavedArrayOfIndices")
    }
    
    func modifyLocalArrayOfNotes(){
        
        GetData.arrayOfNoteIndices = readFromUserDefaultAnArrayOfInt("SavedArrayOfIndices")
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
        writeToUserDefaultAnArrayOfInt(GetData.arrayOfNoteIndices,"SavedArrayOfIndices")
        
    }
    
    func sortLocalArrayOfNotes() {
        var i=0
        var sortedArray = [oneNote]()
        
        GetData.arrayOfNoteIndices = readFromUserDefaultAnArrayOfInt("SavedArrayOfIndices")
        while i<GetData.localArrayOfNotes.count {
            if GetData.arrayOfNoteIndices.count == 0 {
                saveArrayOfNoteIndices()
            }
            sortedArray.append(GetData.localArrayOfNotes[GetData.arrayOfNoteIndices[i]-1])
            i+=1
        }
        GetData.localArrayOfNotes = sortedArray
    }
   
    static func updateOrDeleteNoteOfCoreData(_ index:Int,_ deleteNoteFlag:Bool,_ title:String,_ text:String,_ archiveStatus:Bool,_ markImportantStatus:Bool,_ reminderDateTimeInfo:String){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return}
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        fetchRequest.predicate = NSPredicate(format: "title = %@",title)
        
        do{
            let test = try managedContext.fetch(fetchRequest)
            
            let object = test[0] as! NSManagedObject
            
            if deleteNoteFlag == true {
                managedContext.delete(object)
            }
            else {//i.e. in case of updating note
                object.setValue(title, forKey:"title" )
                object.setValue(text,forKey:"noteText")
                object.setValue(archiveStatus, forKey: "archived")
                object.setValue(markImportantStatus, forKey: "important")
            }
            
            do {
                try managedContext.save()
            }
            catch {
                print("Error 1")
            }
        }
        catch{
            print("Error 2")
        }
        
        if !deleteNoteFlag{//i.e. in case of updating note
            GetData.localArrayOfNotes[index].oneTitle = title
            GetData.localArrayOfNotes[index].note = text
            GetData.localArrayOfNotes[index].archived = archiveStatus
            GetData.localArrayOfNotes[index].important = markImportantStatus
            GetData.localArrayOfNotes[index].reminderDateTimeInfo = reminderDateTimeInfo
        }
    }
}
