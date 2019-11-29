
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
    var archived = GetData.archiveStatusOfNoteToBeEdited
    var index = GetData.indexOfNoteToBeEdited
    var deleteNoteFlag = false
    var markedImportant = GetData.importantStatusOfNoteToBeEdited
    var reminderAdded = false
    var reminderDateTimeInfo = ""
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
        EditNoteModel.updateOrDeleteNoteOfCoreData(index, deleteNoteFlag, noteTitle.text!, note.text, archived, markedImportant,reminderDateTimeInfo)
    }
    
    @IBAction func deleteNote(_ sender: UIButton) {
        deleteNoteFlag = true
        //updateOr(noteTitle.text!,note.text,archived))
       EditNoteModel.updateOrDeleteNoteOfCoreData(index, deleteNoteFlag, noteTitle.text!, note.text, archived, markedImportant, reminderDateTimeInfo)
        deleteNoteFlag = false
        GetData.localArrayOfNotes.remove(at: GetData.indexOfNoteToBeEdited)
        
        noteEditor.removeFromArrayOfIndices()
        noteEditor.modifyLocalArrayOfNotes()
        
        GetData.shouldRetrieveData = false
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
            performSegue(withIdentifier: "saveEditedNote", sender: self)
        }
        else {
            unArchiveTheArchivedNote()
            GetData.archiveStatusOfNoteToBeEdited = false
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
    
////////////////////////////////////////REMINDER FUNCTIONALITIES//////////////////////////////////
    @IBAction func addReminder(_ sender: UIButton) {
        setViewConstraints(553, 0, 189, 300, 530, 250)
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseIn, animations: {
            self.view.layoutIfNeeded()
        }) { (animationComplete) in
            print("Animation complete")
        }
        
      // performSegue(withIdentifier: "goToCalendar", sender: self)
    
        //                Fundooo.addReminder(noteTitle: reminderTitle, Date: date, Time: time)
        //                Fundooo.showNotification(dateTime: dateTime)
    }
    
    @IBAction func selectDateTime(_ sender: UIDatePicker) {
        let dateComponents = Date.getDayMonthYearHourMinute(sender.date)
       
        if !GetData.archiveStatusOfNoteToBeEdited {
            LocalNotificationController.triggerLocalNotification(dateComponents,GetData.localArrayOfNotes[GetData.indexOfNoteToBeEdited])
        }
        else {
            LocalNotificationController.triggerLocalNotification(dateComponents,GetData.arrayOfArchivedNotes[GetData.indexOfNoteToBeEdited])
        }
        
        let dateString = getDateTime(sender.date)
        
        reminderDateTimeInfo = dateString
    }
    
    func getDateTime(_ date:Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy,EEEE HH:mm"
        let strDate = dateFormatter.string(from: date)
        //strDate = convertDateFormatter(date: strDate)
        return strDate
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
    
   
    //    func addReminder(noteTitle: String, Date: String, Time: String) {
    //
    //        let appDelegate = UIApplication.shared.delegate as! AppDelegate
    //        let context = appDelegate.persistentContainer.viewContext
    //        let entity = NSEntityDescription.entity(forEntityName: "Reminder", in: context)
    //        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Reminder")
    //        let newUser = NSManagedObject(entity: entity!, insertInto: context)
    //        request.returnsObjectsAsFaults = false
    //        var cnt = -1
    //
    //        do {
    //            let result = try context.fetch(request)
    //            for _ in result as! [NSManagedObject] {
    //                cnt += 1
    //            }
    //        } catch {
    //            print("Failed")
    //        }
    
    
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
        EditNoteModel.updateOrDeleteNoteOfCoreData(index,deleteNoteFlag, noteTitle.text!,note.text,archived,markedImportant,reminderDateTimeInfo)
        
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


