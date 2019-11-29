
import UIKit
import CoreData

extension UIColor {
    
    class func color(data:Data) -> UIColor? {
        return try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? UIColor
    }
    
    func encode() -> Data? {
        return try? NSKeyedArchiver.archivedData(withRootObject: self, requiringSecureCoding: false)
    }
}

class TakeANote: UIViewController, UITextViewDelegate {
    
    var colour = UIColor.gray
    let arrayOfColors = [UIColor.gray,UIColor.red,UIColor.orange,UIColor.yellow,UIColor.blue,UIColor.green,UIColor.purple,UIColor.magenta,UIColor.brown]
    
    @IBOutlet weak var noteTitle: UITextField!
    
    @IBOutlet weak var optionsTop: NSLayoutConstraint!
    
    @IBOutlet weak var optionsBottom: NSLayoutConstraint!
    var humburgerMenuIsVisible = false
    
    @IBAction func back(_ sender: Any) {
        performSegue(withIdentifier: "AfterAddingNote", sender: self)
    }
    
    func setColor(_ color:UIColor){
        self.colour = color
        self.note.backgroundColor = color
        self.noteTitle.backgroundColor = color
    }
    
    @IBAction func redButton(_ sender: UIButton) {
        setColor(UIColor.red)
    }
    
    @IBAction func orrangeButton(_ sender: UIButton) {
        setColor(UIColor.orange)
    }
    
    @IBAction func yellowButton(_ sender: UIButton) {
        setColor(UIColor.yellow)
    }
    
    @IBAction func blueButton(_ sender: UIButton) {
        setColor(UIColor.blue)
    }
    
    @IBAction func greenButton(_ sender: UIButton) {
        setColor(UIColor.green)
    }
    
    @IBAction func purpleButton(_ sender: UIButton) {
        setColor(UIColor.purple)
    }
    
    @IBAction func magentaButton(_ sender: UIButton) {
        setColor(UIColor.magenta)
    }
    
    @IBAction func brownButton(_ sender: UIButton) {
        setColor(UIColor.brown)
    }
    
    @IBAction func takeANode(_ sender: UIButton) {
        let title = self.noteTitle.text
        let text = self.note.text
        let color = self.colour
        let archived = false
        let markedImportant = false
        addNote(title!,text!,color,archived,markedImportant)
    }
    
    @IBOutlet weak var note: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        note.text = "Note"
        note.textColor = UIColor.lightGray
        self.note.delegate = self
        optionsTop.constant = 1000
        optionsBottom.constant = -1000-212
        // Do any additional setup after loading the view.
    }
    
    @IBAction func optionsHamburgerClick(_ sender: UIButton) {
        if !humburgerMenuIsVisible {
            self.humburgerMenuIsVisible = true
            optionsTop.constant = 508
            optionsBottom.constant = -720
        }
        else {
            self.humburgerMenuIsVisible = false
            optionsTop.constant = 1000
            optionsBottom.constant = -1000-212
        }
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseIn, animations: {
            self.view.layoutIfNeeded()
        }) { (animationComplete) in
            print("Animation complete")
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.white
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Note"
            textView.textColor = UIColor.lightGray
        }
    }
    
    func addNote(_ title:String,_ text:String,_ color:UIColor,_ archived:Bool,_ markedImportant:Bool) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return}
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let userEntity = NSEntityDescription.entity(forEntityName: "Note",in: managedContext)
        
        let user = NSManagedObject(entity:userEntity!, insertInto: managedContext)
        
        let myColorData = color.encode()
        
        user.setValue(text, forKeyPath: "noteText")
        
        user.setValue(title, forKeyPath: "title")
        
        user.setValue(myColorData, forKeyPath: "color")
        
        user.setValue(archived, forKeyPath: "archived")
        
        user.setValue(markedImportant, forKeyPath: "important")
        
        //Update the saved array of note indices
        var arrayOfNoteIndices = UserDefaults.standard.object(forKey: "SavedArrayOfIndices") as? [Int] ?? [Int]()
        let totalNotes = arrayOfNoteIndices.count
        
        arrayOfNoteIndices.append(totalNotes+1)
       
        UserDefaults.standard.set(arrayOfNoteIndices, forKey: "SavedArrayOfIndices")
        UserDefaults.standard.synchronize()
        
        textViewDidEndEditing(note)
        GetData.indexOfNoteToBeEdited = totalNotes
        GetData.positionOfNoteToBeEdited = totalNotes + 1
        GetData.titleOfNoteToBeEdited = title
        GetData.textOfNoteToBeEdited = text
        
        var i=0
        while i<arrayOfColors.count{
            if arrayOfColors[i]==color{
                GetData.colorOfNoteToBeEdited = i+1
            }
            i+=1
        }
    
        GetData.localArrayOfNotes.append(oneNote(title,text,GetData.colorOfNoteToBeEdited,totalNotes+1,archived,markedImportant,""))
        
        GetData.shouldRetrieveData = false
        GetData.noteJustAdded = true
        
        print("Local array of notes after adding note and before retrieving notes")
        for i in 0..<GetData.localArrayOfNotes.count {
            print("\(GetData.localArrayOfNotes[i].oneTitle)")
        }
        
        performSegue(withIdentifier: "saveNoteClick", sender: self)
        do{
            try managedContext.save()
        } catch {
            print("Failed saving")
        }
    }
}
