
import Foundation


//Driver program
var cliniqueManager = CliniqueManager()
var exitFlag = false
while exitFlag == false {
    print("Enter 1 for searching doctor, 2 for searching patient, 3 for taking appointment, 4 for printing doctor patient report, 5 for exit.")
    let operation = Int(readLine()!)
    if operation == 1{
        cliniqueManager.searchDoctor()
    }
    if operation == 2{
        cliniqueManager.searchPatient()
    }
    if operation == 3{
        cliniqueManager.takeAppointment()
    }
    if operation == 4{
        cliniqueManager.printReport()
    }
    if operation == 5{
        exitFlag = true
    }
}

