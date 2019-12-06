import Alamofire
import UIKit

extension DashBoardModel{
    
    
    
    func getNotesFromServer(completion: @escaping ((_ noteList: [oneNote]) -> Void)) {
        let noteEditor = EditNoteModel()
//        GetData.arrayOfNoteIndices = [1,2,3]
//        noteEditor.writeToUserDefaultAnArrayOfInt(GetData.arrayOfNoteIndices,"SavedArrayOfIndices")
        GetData.arrayOfNoteIndices = noteEditor.readFromUserDefaultAnArrayOfInt("SavedArrayOfIndices")
        print("12 -> DashboardModel -> arrayOfNoteIndices -> \(GetData.arrayOfNoteIndices)")
        print("13 -> DashboardModel -> localArrayOfNotes -> \(GetData.localArrayOfNotes)")

       
        
        let takeANote = TakeANote()
        let dashBoardModel = DashBoardModel()
       // let dashBoardController =  DashboardController()
        
        //let dispatchgroup = DispatchGroup()
        let access_token: String = UserDefaults.standard.string(forKey: "accessToken")!
        let url: String = WebServicesCommonData.getNotesListURL + "?access_token=" + access_token
        
        //dispatchgroup.enter()
        
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
                    
                    for i in 0..<secondData.count {
                        
                        let notesData = secondData[i] as NSDictionary
                        let noteArchiveStatus = notesData["isArchived"] as! Bool
                        let noteReminderInfo = ""//notesData["reminder"] as! String
                        let noteImportantStatus = notesData["isPined"] as! Bool
                        let noteTitle = notesData["title"] as! String
                        let noteDescription = notesData["description"] as! String
                        let noteColor = UIColor().hexStringToUIColor(hex: notesData["color"] as! String)
                        let noteId = notesData["id"] as! String
                       print("45 -> DashboardModel -> \(i) \(noteTitle) \(noteDescription)")
                        takeANote.addNoteToCoreData(noteTitle,noteDescription,noteColor,noteArchiveStatus,noteImportantStatus,noteReminderInfo,Date.getCurrentDate())
                        
                        GetData.localArrayOfNotes.append(oneNote(noteTitle,noteDescription,1,i+1,noteArchiveStatus,noteImportantStatus,noteReminderInfo))
                        
                        let noteIdElement = noteIdStruct(noteTitle,noteDescription,noteId)
                        
                        GetData.noteIdList.append(noteIdElement)
                        
                    }
                case let .failure(error):
                    print(error)
                }
                if GetData.localArrayOfNotes.count != GetData.arrayOfNoteIndices.count{
                    DashBoardModel.saveArrayOfIndices()
                }
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


