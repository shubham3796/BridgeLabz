import UIKit
import Alamofire

extension ArchiveModel{
  
    func retrieveRemoteArchiveNotes(completion: @escaping ((_ noteList: [oneNote]) -> Void)){
        let access_token: String = UserDefaults.standard.string(forKey: "accessToken")!
        let url: String = WebServicesCommonData.getArchiveNotesListURL + "?access_token=" + access_token
        
        let dispatchgroup = DispatchGroup()
        dispatchgroup.enter()
        
        AF.request(
            url,
            method: .get
            )
            .validate(contentType: ["application/json"])
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                switch response.result {
                case .success:
                    guard let rootJSON = try? JSONSerialization.jsonObject(with: response.data!, options: [])
                        else { print("failed")
                            return
                    }
                    let JSON = rootJSON as! [String: Any]
                    let firstData  = JSON["data"] as! [String: Any]
                    let secondData = firstData["data"] as! [[String: Any]]
                    
                    for i in 0..<secondData.count {
                        let notesData = secondData[i] as NSDictionary
                        let noteArchiveStatus = notesData["isArchived"] as! Bool
                        let noteID = notesData["id"] as! String
                        let noteImportantStatus = notesData["isPined"] as! Bool
                        let noteTitle = notesData["title"] as! String
                        let noteDescription = notesData["description"] as! String
                        let noteColor = UIColor().hexStringToUIColor(hex: notesData["color"] as! String)
                        let noteReminderInfo = notesData["reminder"] as! [String]
                        
                        let color2 = noteColor
                        var colorFoundFlag = false
                        var j = 0
                        
                        while j < CommonUIController.arrayOfColors.count && colorFoundFlag == false{
                            
                            let color1 = CommonUIController.arrayOfColors[j]
                            if UIColor().compareUIColors(color1,color2) {
                                
                                let indexx = GetData.arrayOfArchivedNotes.count + 1
                                GetData.arrayOfArchivedNotes.append(oneNote(noteTitle,noteDescription,j+1,indexx,noteArchiveStatus,noteImportantStatus,noteReminderInfo[0]))
                                
                                colorFoundFlag = true
                            }
                            j += 1
                        }
                    }
                    
                case let .failure(error):
                    print(error)
                }
                GetData.shouldRetrieveArchiveNotes = false
                completion(GetData.arrayOfArchivedNotes)
                
                dispatchgroup.leave()
        }
        
        dispatchgroup.notify(queue: .main) {
//            self.fetchArchiveNotes()
//            self.archiveCollectionView.reloadData()
        }
    }
    }

