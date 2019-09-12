class DoctorPatientFinder {
    
    static func findDoctor(_ arrayOfDoctors:[Doctor],_ searchCriteria:Int) {
        if searchCriteria == 1 {
            print("Enter the name of doctor")
            let searchDoctorName = readLine()
            for doctor in arrayOfDoctors {
                if doctor.name == searchDoctorName {
                    print("Found Dr.\(doctor.name) with details : Name: \(doctor.name), ID: \(doctor.id), Specialization: \(doctor.specialization), Number of appointments: In AM -\(doctor.availability.am), In PM - \(doctor.availability.pm)")
                }
            }
        }
        
        if searchCriteria == 2{
            print("Enter the ID of doctor")
            let searchDoctorId = readLine()
            for doctor in arrayOfDoctors {
                if doctor.id == searchDoctorId {
                    print("Found \(doctor.id) with details : Name: \(doctor.name), ID: \(doctor.id), Specialization: \(doctor.specialization), Number of appointments: In AM -\(doctor.availability.am), In PM - \(doctor.availability.pm)")
                }
            }
        }
        
        if searchCriteria == 3{
            print("Enter the specialization of doctor")
            let searchDoctorSpecialization = readLine()
            for doctor in arrayOfDoctors {
                if doctor.specialization == searchDoctorSpecialization {
                    print("Found \(doctor.specialization) specialization with doctor details : Name: \(doctor.name), ID: \(doctor.id), Specialization: \(doctor.specialization), Number of appointments: In AM -\(doctor.availability.am), In PM - \(doctor.availability.pm)")
                }
            }
        }
        
        if searchCriteria == 4 {
            print("Enter 1 to check availability in am, 2 for pm, 3 for both.")
            let temporaryAvailability = Int(readLine()!)
            //let searchDoctorAvailability = Availability()
            if temporaryAvailability == 1{
                for doctor in arrayOfDoctors {
                    if doctor.availability.am < 5 {
                        print("Doctor available in this time : Name: \(doctor.name), ID: \(doctor.id), Specialization: \(doctor.specialization), Number of appointments: In AM -\(doctor.availability.am), In PM - \(doctor.availability.pm)")
                    }
                }
            }
            else if temporaryAvailability == 2 {
                for doctor in arrayOfDoctors {
                    if doctor.availability.pm < 5 {
                        print("Doctor available in this time : Name: \(doctor.name), ID: \(doctor.id), Specialization: \(doctor.specialization), Number of appointments: In AM -\(doctor.availability.am), In PM - \(doctor.availability.pm)")
                    }
                }
            }
            else {
                for doctor in arrayOfDoctors {
                    if doctor.availability.pm < 5 && doctor.availability.am == 5 {
                        print("Doctor available in this time : Name: \(doctor.name), ID: \(doctor.id), Specialization: \(doctor.specialization), Number of appointments: In AM -\(doctor.availability.am), In PM - \(doctor.availability.pm)")
                    }
                }
            }
        }
    }
    static func findPatient(_ arrayOfPatients:[Patient],_ searchCriteria:Int) {
        if searchCriteria == 1{
            print("Enter the name of patient")
            let searchPatientName = readLine()
            for patient in arrayOfPatients {
                if patient.name == searchPatientName {
                    print("Found \(patient.name) with details Name: \(patient.name), ID: \(patient.id), Mobie number: \(patient.mobileNumber), Age: \(patient.age)")
                }
            }
        }
        
        if searchCriteria == 2{
            print("Enter the ID of patient")
            let searchPatientId = readLine()
            for patient in arrayOfPatients {
                if patient.id == searchPatientId {
                    print("Found \(patient.id) with details Name: \(patient.name), ID: \(patient.id), Mobie number: \(patient.mobileNumber), Age: \(patient.age)")
                }
            }
        }
        
        if searchCriteria == 3{
            print("Enter the mobile number of patient")
            let searchPatientMobileNumber = readLine()
            for patient in arrayOfPatients {
                if patient.mobileNumber == searchPatientMobileNumber {
                    print("Found \(patient.mobileNumber) with details Name: \(patient.name), ID: \(patient.id), Mobie number: \(patient.mobileNumber), Age: \(patient.age)")
                }
            }
        }
    }
    
}
