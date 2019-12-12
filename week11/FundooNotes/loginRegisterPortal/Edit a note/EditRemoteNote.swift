//
//  EditRemoteNote.swift
//  loginRegisterPortal
//
//  Created by admin on 09/12/19.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit
import Alamofire

struct noteTitleDescriptionUpdate : Encodable{
    var noteId : String
    var title : String
    var description : String
    
    init(noteId:String,title:String,description:String){
        self.noteId = noteId
        self.title = title
        self.description = description
    }
}

struct markUnmarkImportant : Encodable{
    var noteIdList : [String]
    var isPined : Bool
    init(_ noteIdList:String,_ isPined:Bool){
        self.noteIdList = [noteIdList]
        self.isPined = isPined
    }
}

class EditRemoteNote: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func updateRemoteNote(_ noteID:String,_ noteTitle:String,_ noteDescription:String){
        
        let dispatchgroup = DispatchGroup()
        let access_token: String = UserDefaults.standard.string(forKey: "accessToken")!
        let url: String = WebServicesCommonData.updateNotesURL + "?access_token=" + access_token
        
        let noteUpdate = noteTitleDescriptionUpdate(noteId: noteID, title: noteTitle, description: noteDescription)
        
        dispatchgroup.enter()
        
        AF.request(
            url,
            method: .post,
            parameters: noteUpdate,
            encoder: JSONParameterEncoder.default
            )
            .validate(contentType: ["application/json"])
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                switch response.result {
                case .success:
                    print("REMOTE NOTE UPDATED SUCCESSFULLY")
                case .failure:
                    print(response.error!)
                }
                dispatchgroup.leave()
        }
    }
    
    func markUnmarkImportantNote(_ noteId:String,_ importantStatus:Bool){

        let dispatchgroup = DispatchGroup()
        let access_token: String = UserDefaults.standard.string(forKey: "accessToken")!
        
        let url: String = WebServicesCommonData.pinUnpinNoteURL + "?access_token=" + access_token
        
        let pinUnpinNote = markUnmarkImportant("\(noteId)", importantStatus)
        
        dispatchgroup.enter()
        
        AF.request(
            url,
            method: .post,
            parameters: pinUnpinNote,
            encoder: JSONParameterEncoder.default
            )
            .validate(contentType: ["application/json"])
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                switch response.result {
                case .success:
                    print("REMOTE NOTE MARKED SUCCESSFULLY")
                case .failure:
                    print(response.error!)
                }
                dispatchgroup.leave()
        }
    }
    // Do any additional setup after loading the view.
    
}
