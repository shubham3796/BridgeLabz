
import Foundation

var inputString:String
var modifiedString=""

struct regularExpression {
    private var modifiedString:String
    mutating func generateRegularExpression(_ pattern: String,_ inputString: String,_ replacePatternWith: String) -> String {
        modifiedString = inputString.replacingOccurrences( of: pattern, with: replacePatternWith,options: .regularExpression)
        return modifiedString
    }//end function
    init  (_ modifiedString:String) {//initialize an empty modifiedString
        self.modifiedString=modifiedString
    }
}//end struct definition

//Driver program
//Take input from a file
let inputLocation = NSString(string:"/Users/admin/Documents/week3prob2.txt").expandingTildeInPath
do {
    
    inputString = try NSString(contentsOfFile: inputLocation, encoding: String.Encoding.utf8.rawValue) as String
    
    var temporaryRegularExpression = regularExpression("")
    
    
    modifiedString = temporaryRegularExpression.generateRegularExpression("<<[a-z]*>>",inputString,"Shubham")
    
    modifiedString = temporaryRegularExpression.generateRegularExpression("<<[a-z]* [a-z]*>>" , modifiedString , "Shubham Vaishnav" )
    
    modifiedString = temporaryRegularExpression.generateRegularExpression("91-.{10}" , modifiedString , "91-8877010483" )
    
    let currentDate = Calendar.current.component(.day,from:Date())
    let currentMonth = Calendar.current.component(.month,from:Date())
    let currentYear = Calendar.current.component(.year,from:Date())
    modifiedString = temporaryRegularExpression.generateRegularExpression("[0-9]{2}/[0-9]{2}/[0-9]{4}" , modifiedString , "\(currentDate)/\(currentMonth)/\(currentYear)" )
    print(modifiedString)
    
}
catch let error {
    print(error.localizedDescription)
}

