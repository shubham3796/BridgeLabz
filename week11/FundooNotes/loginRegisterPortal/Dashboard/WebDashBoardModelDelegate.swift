import Alamofire
import UIKit
import CoreData


extension DashBoardModel{
    
    func addNoteToCoreDataWhileRetrieving(_ title:String,_ text:String,_ color:UIColor,_ archived:Bool,_ markedImportant:Bool,_ reminderInfo:String,_ reminderDate:Date){
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
        
        user.setValue(reminderInfo, forKeyPath: "reminderInfo")
        
        user.setValue(reminderDate, forKeyPath: "reminderDate")
        
        do{
            try managedContext.save()
        } catch {
            print("Failed saving in WebDashboardModelDelegate line 35")
        }
        
    }
    
    func getNotesFromServer(completion: @escaping ((_ noteList: [oneNote]) -> Void)) {
        
//        let noteEditor = EditNoteModel()
//        GetData.arrayOfNoteIndices = [1,2,3,4,5,6,7,8,9]
//        noteEditor.writeToUserDefaultAnArrayOfInt(GetData.arrayOfNoteIndices,"SavedArrayOfIndices")
//        GetData.arrayOfNoteIndices = noteEditor.readFromUserDefaultAnArrayOfInt("SavedArrayOfIndices")

        let takeANote = TakeANote()
        let access_token: String = UserDefaults.standard.string(forKey: "accessToken")!
        print("Access Token -> \(access_token)")
        let url: String = WebServicesCommonData.getNotesListURL + "?access_token=" + access_token

        AF.request(
            url,
            method: .get
            ).responseJSON { response in
                switch response.result {
                case .success:
                    guard let rootJSON = try? JSONSerialization.jsonObject(with: response.data!, options: [])
                        else { print("failed")
                            return
                    }
                    let JSON = rootJSON as! [String: Any]
                    let firstData  = JSON["data"] as! [String: Any]
                    let secondData = firstData["data"] as! [[String: Any]]
        
                    CoreDataController.deleteWholeCoreData()
                    GetData.localArrayOfNotes = []
                    GetData.arrayOfArchivedNotes = []
                    GetData.arrayOfReminderedNotes = []
                    GetData.noteIdList = []
                    
                    for i in 0..<secondData.count {
                        
                        let notesData = secondData[i] as NSDictionary
                        let noteArchiveStatus = notesData["isArchived"] as! Bool
                        let noteReminderInfo = notesData["reminder"] as! [String]
                        
                        let noteImportantStatus = notesData["isPined"] as! Bool
                        let noteTitle = notesData["title"] as! String
                        let noteDescription = notesData["description"] as! String
                        let noteColor = UIColor().hexStringToUIColor(hex: notesData["color"] as! String)
                        let noteId = notesData["id"] as! String
                       
                        
                        let noteReminderInfoString = noteReminderInfo.joined(separator: "-")
                    
                        let color2 = noteColor
                        
                        var j = 0
                        var colorFoundFlag = false
                        while j < CommonUIController.arrayOfColors.count && colorFoundFlag == false{
                            
                            let color1 = CommonUIController.arrayOfColors[j]
                            if UIColor().compareUIColors(color1,color2) {
                                self.addNoteToCoreDataWhileRetrieving(noteTitle,noteDescription,noteColor,noteArchiveStatus,noteImportantStatus,noteReminderInfoString,Date.getCurrentDate())
                                
                                if noteArchiveStatus {
                                   let indexx = GetData.arrayOfArchivedNotes.count + 1
                                    GetData.arrayOfArchivedNotes.append(oneNote(noteTitle,noteDescription,j+1,indexx,noteArchiveStatus,noteImportantStatus,noteReminderInfoString))
                                }
                                else {
                                   let indexx = GetData.localArrayOfNotes.count + 1
                                    GetData.localArrayOfNotes.append(oneNote(noteTitle,noteDescription,j+1,indexx,noteArchiveStatus,noteImportantStatus,noteReminderInfoString))
                                }
                                
                                colorFoundFlag = true
                            }
                        let noteIdElement = noteIdStruct(noteTitle,noteDescription,noteId)
                        GetData.noteIdList.append(noteIdElement)
                        j += 1
                        }
                    }
                case let .failure(error):
                    print(error)
                }
                print("WebDashBoardModel -> 78 -> arrayOfNoteIndices after retrieving notes -> \(GetData.arrayOfNoteIndices)")
//                if GetData.localArrayOfNotes.count != GetData.arrayOfNoteIndices.count{
//                    DashBoardModel.saveArrayOfIndices()
//                }
                GetData.arrayOfNoteIndices = UserDefaults.standard.object(forKey: "SavedArrayOfIndices") as? [Int] ?? [Int]()
                //GetData.arrayOfNoteIndices = [1,2,3]
                
                UserDefaults.standard.set(GetData.arrayOfNoteIndices, forKey: "SavedArrayOfIndices")
                UserDefaults.standard.synchronize()
                
                print("WebDashBoardModel -> 82 -> arrayOfNoteIndices after some processing -> \(GetData.arrayOfNoteIndices)")
                
                DashBoardModel.sortLocalArrayOfNotes()
                GetData.indexOfNoteToBeEdited = 1000
                GetData.shouldRetrieveData = false
                
                completion(GetData.localArrayOfNotes)
               // dispatchgroup.leave()
        }
//        dispatchgroup.notify(queue: .main) {
//            //dashBoardController.viewWillAppear(true)
//            return true
//        }
    }
    
}








//  var noteColorNumber = 0

//                        var foundFlag=false
//                        if !noteArchiveStatus{
//                            var j=0
//                            while j < DashboardControllerDelegate.arrayOfColors.count && foundFlag == false {
//                                if noteColor == DashboardControllerDelegate.arrayOfColors[j]{
//                                    noteColorNumber = j
//                                    foundFlag = true
//                                }
//                                j+=1
//                            }
//
//                        }

//                        let noteData = oneNote(noteDescription,noteTitle,noteColorNumber,i+1,noteArchiveStatus,noteImportantStatus,noteReminderInfo)


