class AppointmentFinalizer{
    
    static func takeAppointment(_ doctorId:String,_ arrayOfDoctors : [Doctor]){
        var appointmentNeededFlag = true
        
        while appointmentNeededFlag == true {
            
            print("Enter time in which you want to seek appointment : 1 for am, 2 for pm")
            let appointmentTime = Int(readLine()!)
            appointmentNeededFlag = true
            
            for doctor in arrayOfDoctors {
                if appointmentNeededFlag == true {
                    if doctor.id == doctorId {
                        if appointmentTime == 1 {
                            if doctor.availability.am < 5
                            {
                                doctor.availability.am += 1
                                print("Appointment finalized")
                                appointmentNeededFlag = false
                            }
                            else {
                                print("Doctor is not available in this time.")
                                print("Do you want to check doctor's avaialability in a different time? Type 1 for Yes, 0 for No")
                                let searchAnotherTimeFlag = readLine()!
                                if searchAnotherTimeFlag == "0" {
                                    appointmentNeededFlag = false
                                }
                            }
                        }
                        else {
                            if doctor.availability.pm < 5
                            {
                                doctor.availability.pm += 1
                                print("Appointment finalized")
                                appointmentNeededFlag = false
                            }
                            else {
                                print("Doctor is not available in this time.")
                                print("Do you want to check doctor's avaialability in a different time? Type 1 for Yes, 0 for No")
                                let searchAnotherTimeFlag = readLine()!
                                if searchAnotherTimeFlag == "0" {
                                    appointmentNeededFlag = false
                                }
                            }
                        }
                    }
                }
            }//end for
        }
    }
}//end class AppointmentFinalizer
