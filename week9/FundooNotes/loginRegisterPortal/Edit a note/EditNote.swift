
import UIKit
import CoreData

class EditNote: UIViewController {
    let arrayOfColors = CommonUIController.arrayOfColors
    
    @IBOutlet weak var note: UITextView!
    @IBOutlet weak var noteTitle: UITextField!
    @IBOutlet weak var archiveButton: UIButton!
    @IBOutlet weak var markImportantButton: UIButton!
    @IBOutlet weak var dateAndTimePicker: UIDatePicker!
    @IBOutlet weak var calendarTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var calendarBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var noteTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var noteBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var saveNoteTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var saveNoteBottomConstraint: NSLayoutConstraint!
    
    var previousTitle=""
    var noteIndex = 0
    var archived = false
    var index = GetData.indexOfNoteToBeEdited
    var deleteNoteFlag = false
    var markedImportant = false
    var reminderAdded = false
    var reminderInfo = ""
    var reminderDate = Date.getCurrentDate()
    var noteEditor = EditNoteModel()
    var archivedNoteEditor = EditArchivedNoteModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewConstraints(769, -216, 189, 100,745,30)
        saveDetailsOfNoteToBeEdited()
        setDetailsVisibleOnThisPage()
        setArchiveButtonText()
        setMarkImportantButtonText()
        // Do any additional setup after loading the view.
    }
    
    func saveDetailsOfNoteToBeEdited(){
        previousTitle = GetData.titleOfNoteToBeEdited
        archived = GetData.archiveStatusOfNoteToBeEdited
        index = GetData.indexOfNoteToBeEdited
        markedImportant = GetData.importantStatusOfNoteToBeEdited
        reminderInfo = GetData.reminderInfoOfNoteToBeEdited
        reminderDate = GetData.reminderDateOfNoteToBeEdited
        noteTitle.text = GetData.titleOfNoteToBeEdited
    }
    
    func setDetailsVisibleOnThisPage(){
        note.text = GetData.textOfNoteToBeEdited
        note.backgroundColor = arrayOfColors[GetData.colorOfNoteToBeEdited - 1]
        noteTitle.backgroundColor = arrayOfColors[GetData.colorOfNoteToBeEdited - 1]
    }
    
    func setArchiveButtonText(){
        if GetData.archiveStatusOfNoteToBeEdited == true{
            archiveButton.setTitle("Unarchive", for: .normal)
        }
        else {
            archiveButton.setTitle("Archive", for: .normal)
        }
    }
    func setMarkImportantButtonText(){
        if GetData.importantStatusOfNoteToBeEdited == true{
            markImportantButton.setTitle("Unmark", for: .normal)
        }
        else {
            markImportantButton.setTitle("Mark", for: .normal)
        }
    }
    
    //////////////////////////////////////////////////////////////////////////
    
    @IBAction func markImportant(_ sender: UIButton) {
        markedImportant = !markedImportant
        GetData.importantStatusOfNoteToBeEdited = !GetData.importantStatusOfNoteToBeEdited
        setMarkImportantButtonText()
        index = GetData.indexOfNoteToBeEdited
        EditNoteModel.updateOrDeleteNoteOfCoreData(index, deleteNoteFlag, noteTitle.text!, note.text, archived, markedImportant,reminderInfo)
    }
    
    @IBAction func deleteNote(_ sender: UIButton) {
        deleteNoteFlag = true
        
        EditNoteModel.updateOrDeleteNoteOfCoreData(index, deleteNoteFlag, noteTitle.text!, note.text, archived, markedImportant, reminderInfo)
        
        deleteNoteFlag = false
        
        if !GetData.archiveStatusOfNoteToBeEdited {
            if GetData.reminderInfoOfNoteToBeEdited != ""{
                GetData.localArrayOfNotes.remove(at: GetData.indexOfNoteToBeEdited)
                noteEditor.removeFromArrayOfReminderedNoteIndices()
                noteEditor.modifyReminderedArrayOfNotes()
                GetData.shouldRetrieveData = true
            }
            else {
                GetData.localArrayOfNotes.remove(at: GetData.indexOfNoteToBeEdited)
                noteEditor.removeFromArrayOfIndices()
                noteEditor.modifyLocalArrayOfNotes()
                GetData.shouldRetrieveData = false
            }
        }
        else {
            GetData.arrayOfArchivedNotes.remove(at: GetData.indexOfNoteToBeEdited)
            archivedNoteEditor.removeFromArrayOfArchivedNoteIndices()
            archivedNoteEditor.modifyArchivedArrayOfNotes()
            GetData.shouldRetrieveData = false
        }
        
        performSegue(withIdentifier: "editedNote", sender: self)
    }
    
    @IBAction func archiveTheNote(_ sender: UIButton) {
        if GetData.arrayOfNoteIndices == []{
            noteEditor.saveArrayOfNoteIndices()
        }
        if GetData.arrayOfArchivedNoteIndices == []{
            archivedNoteEditor.saveArrayOfArchivedNoteIndices()
        }
        if archived == false {
            archiveNote()
            GetData.archiveStatusOfNoteToBeEdited = true
            archived = true
            performSegue(withIdentifier: "saveEditedNote", sender: self)
        }
        else {
            unArchiveTheArchivedNote()
            GetData.archiveStatusOfNoteToBeEdited = false
            archived = false
        }
    }
    
    func printArrays(_ lineNumber:Int){
        print("")
        print("Status at line \(lineNumber)")
        print("Local array of notes ->  \(GetData.localArrayOfNotes)")
        print("Array of note indices ->  \(GetData.arrayOfNoteIndices)")
        print("Array of archived notes ->  \(GetData.arrayOfArchivedNotes)")
        print("Array of archived note indices ->  \(GetData.arrayOfArchivedNoteIndices)")
        print("")
    }
    
    func changeViewToAddReminder(){
        setViewConstraints(553, 0, 189, 300, 530, 250)
        
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseIn, animations: {
            self.view.layoutIfNeeded()
        }) { (animationComplete) in
            print("Animation complete")
        }
        
    }
    
    ////////////////////////////////////////REMINDER FUNCTIONALITIES//////////////////////////////////
    @IBAction func addReminder(_ sender: UIButton) {
        changeViewToAddReminder()
        let numberOfReminderedNotes = GetData.arrayOfReminderedNoteIndices.count
        var arrayOfReminderedNoteIndices = GetData.arrayOfReminderedNoteIndices
        
        if GetData.reminderInfoOfNoteToBeEdited == "" {
            arrayOfReminderedNoteIndices.append(numberOfReminderedNotes+1)
            GetData.arrayOfReminderedNoteIndices = arrayOfReminderedNoteIndices
            UserDefaults.standard.set(arrayOfReminderedNoteIndices, forKey: "SavedArrayOfReminderedNoteIndices")
            UserDefaults.standard.synchronize()
            GetData.arrayOfReminderedNotes.append(oneNote(noteTitle.text!,note.text,GetData.colorOfNoteToBeEdited,numberOfReminderedNotes+1,archived,markedImportant,reminderInfo))
        }
    }
    
    @IBAction func selectDateTime(_ sender: UIDatePicker) {
        let dateComponents = Date.getDateComponentsFromDate(sender.date)
        let dateString = Date.getDateInStringFormat(sender.date)
        reminderInfo = dateString
        reminderDate = sender.date
        
        if !GetData.archiveStatusOfNoteToBeEdited {
            LocalNotificationController.triggerLocalNotification(dateComponents,GetData.localArrayOfNotes[GetData.indexOfNoteToBeEdited])
            
            GetData.localArrayOfNotes[GetData.indexOfNoteToBeEdited].reminderDateTimeInfo = reminderInfo
        }
        else {
            LocalNotificationController.triggerLocalNotification(dateComponents,GetData.arrayOfArchivedNotes[GetData.indexOfNoteToBeEdited])
            
            GetData.arrayOfArchivedNotes[GetData.indexOfNoteToBeEdited].reminderDateTimeInfo = reminderInfo
        }
        
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////
    
    func setViewConstraints(_ calendarTopConstraint:Int,_ calendarBottomConstraint:Int,_ noteTopConstraint:Int,_ noteBottomConstraint:Int,_ saveNoteTopConstraint:Int,_ saveNoteBottomConstraint:Int){
        self.calendarTopConstraint.constant = CGFloat(calendarTopConstraint)
        self.calendarBottomConstraint.constant = CGFloat(calendarBottomConstraint)
        self.noteTopConstraint.constant = CGFloat(noteTopConstraint)
        self.noteBottomConstraint.constant = CGFloat(noteBottomConstraint)
        self.saveNoteTopConstraint.constant = CGFloat(saveNoteTopConstraint)
        self.saveNoteBottomConstraint.constant = CGFloat(saveNoteBottomConstraint)
    }
    
    @IBAction func back(_ sender: UIButton) {
        if GetData.openArchive == false {
            GetData.indexOfNoteToBeEdited = 1000
            GetData.shouldRetrieveData = false
            performSegue(withIdentifier: "editedNote", sender: self)
        }
        else {
            GetData.openArchive = false
            performSegue(withIdentifier: "openArchiveAfterEdittingNote", sender: self)
        }
    }
    
    @IBAction func saveNote(_ sender: UIButton) {
        EditNoteModel.updateOrDeleteNoteOfCoreData(index,deleteNoteFlag, noteTitle.text!,note.text,archived,markedImportant,reminderInfo)
        
        if !GetData.archiveStatusOfNoteToBeEdited{
            GetData.shouldRetrieveData = false
            performSegue(withIdentifier: "saveEditedNote", sender: self)
        }
        else {
            GetData.openArchive = false
            performSegue(withIdentifier: "openArchiveAfterEdittingNote", sender: self)
        }
    }
}


