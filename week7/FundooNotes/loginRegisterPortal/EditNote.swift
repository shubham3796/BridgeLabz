
import UIKit
import CoreData

class EditNote: UIViewController {

    @IBOutlet weak var note: UITextView!
    
    @IBOutlet weak var noteTitle: UITextField!
    var previousTitle=""
    var noteIndex : Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        previousTitle = GetData.titleOfNoteToBeEdited
        noteTitle.text = GetData.titleOfNoteToBeEdited
        note.text = GetData.textOfNoteToBeEdited
        // Do any additional setup after loading the view.
    }
    
    func updateNote(_ title:String,_ text:String){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Note")
        fetchRequest.predicate = NSPredicate(format: "title = %@",previousTitle)
        do{
            let test = try managedContext.fetch(fetchRequest)
            
            let objectUpdate = test[0] as! NSManagedObject
            objectUpdate.setValue(noteTitle.text, forKey:"title" )
            objectUpdate.setValue(note.text,forKey:"noteText")
            do{
                try managedContext.save()
            }
            catch{
                print("Error 1")
            }
        }
        catch {
            print("Error 2")

        }
    }

    @IBAction func deleteNote(_ sender: UIButton) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return}
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        fetchRequest.predicate = NSPredicate(format: "title = %@",previousTitle)
        
        do{
            let test = try managedContext.fetch(fetchRequest)
            
            let ObjectToDelete = test[0] as! NSManagedObject
            managedContext.delete(ObjectToDelete)
            
            do {
                try managedContext.save()
            }
            catch {
                print("Error 3")
            }
        }
        catch{
            print("Error 4")
        }
         performSegue(withIdentifier: "editedNote", sender: self)
    }
    
    @IBAction func back(_ sender: UIButton) {
        performSegue(withIdentifier: "editedNote", sender: self)
    }
    
    @IBAction func saveNote(_ sender: UIButton) {
        let title = self.noteTitle.text
        let text = self.note.text
        
        updateNote(title!,text!)
    }
}
