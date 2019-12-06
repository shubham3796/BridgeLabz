
import UIKit
import Alamofire

extension TakeANote {
    struct NoteToBeAdded:Encodable{
        let title:String
        let description:String
        let isPined:Bool
        let isArchived:Bool
        let reminder:String
        let color:String
    }
    
    func saveNoteOnline(_ title:String,_ text:String,_ color:UIColor,_ archived:Bool,_ markedImportant:Bool,_ reminderInfo:String) {
        
        let url:String = WebServicesCommonData.addNoteURL + "?access_token=" + access_token
        print("27 -> \(access_token)")
        print("28 -> [\(reminderInfo)]")
        print("29 -> \(color.hexToString())")
        let addNotes = NoteToBeAdded(title: title, description: text, isPined: markedImportant, isArchived: archived, reminder: reminderInfo, color: "#\(color.hexToString())")
        
        AF.request(
            url,
            method: .post,
            parameters: addNotes,
            encoder: JSONParameterEncoder.default
            )
            .validate(contentType: ["application/json"])
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                switch response.result {
                case .success:
                    print("Note saved online -> TakeANoteDelegate.swift file.")
                case .failure:
                    print("ERROR Note COULD NOT BE saved online -> TakeANoteDelegate.swift file.")
                }
        }
    }
}
