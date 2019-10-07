//
//  TakeANote.swift
//  loginRegisterPortal
//
//  Created by admin on 03/10/19.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit
import CoreData

class TakeANote: UIViewController, UITextViewDelegate {

    @IBOutlet weak var noteTitle: UITextField!
    
    @IBOutlet weak var optionsTop: NSLayoutConstraint!
    
    @IBOutlet weak var optionsBottom: NSLayoutConstraint!
    var humburgerMenuIsVisible = false
    
    @IBAction func back(_ sender: Any) {
         performSegue(withIdentifier: "AfterAddingNote", sender: self)
    }
    
    @IBAction func takeANode(_ sender: UIButton) {
        
        let title = self.noteTitle.text
        let text = self.note.text

        //GetData.arrayOfNotes.append(oneNote(title!,text!))

       // Note("First note","Hi")
        addNote(title!,text!)
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
    
    func addNote(_ title:String,_ text:String) {
        
                guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return}

                let managedContext = appDelegate.persistentContainer.viewContext
       
                let userEntity = NSEntityDescription.entity(forEntityName: "Note",in: managedContext)
       
                let user = NSManagedObject(entity:userEntity!, insertInto: managedContext)

                user.setValue(text, forKeyPath: "noteText")

                user.setValue(title, forKeyPath: "title")
        textViewDidEndEditing(note)
        
        do{
            try managedContext.save()
        } catch {
            print("Failed saving")
        }
        

    }
    
//    override func viewWillDisappear(_ animated: Bool) {
//        let title = noteTitle.text
//        let noteText = note.text
//
//        GetData.arrayOfNotes.append(Note(title!,noteText!))
//    }
    
//    @IBAction func doOnNoteTitleEntered(_ sender: UITextField) {
//    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
