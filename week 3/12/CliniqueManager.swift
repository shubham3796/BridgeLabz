class CliniqueManager {
    var arrayOfDoctors : [Doctor]
    var arrayOfPatients : [Patient]
    
    init(){
        arrayOfDoctors = [Doctor]()
        arrayOfPatients = [Patient]()
        var temporaryDoctor = Doctor("Dr Pradeep","1","Cardiac")
        arrayOfDoctors.append(temporaryDoctor)
        temporaryDoctor = Doctor("Dr Preeti","2","Gyno")
        arrayOfDoctors.append(temporaryDoctor)
        temporaryDoctor = Doctor("Dr Rahul","3","Child")
        arrayOfDoctors.append(temporaryDoctor)
        
        var temporaryPatient = Patient("Shubham","1","8877010483",25)
        arrayOfPatients.append(temporaryPatient)
        temporaryPatient = Patient("Ravindra","2","9993050433",20)
        arrayOfPatients.append(temporaryPatient)
        temporaryPatient = Patient("Sudipto","3","9752877090",30)
        arrayOfPatients.append(temporaryPatient)
        temporaryPatient = Patient("Vishnu","4","9175362765",50)
        arrayOfPatients.append(temporaryPatient)
    }
    
    func searchDoctor(){
        print("Enter 1 to search by Name, 2 for ID, 3 for specialization and 4 for availability")
        let searchCriteria = Int(readLine()!)
        DoctorPatientFinder.findDoctor(arrayOfDoctors,searchCriteria!)
    }
    
    func searchPatient(){
        print("Enter 1 to search by Name, 2 for ID, 3 for mobileNumber")
        let searchCriteria = Int(readLine()!)
        DoctorPatientFinder.findPatient(arrayOfPatients,searchCriteria!)
    }
    
    func takeAppointment(){
        print("Enter doctor ID to request for appointment")
        let doctorId = readLine()
        AppointmentFinalizer.takeAppointment(doctorId!,arrayOfDoctors)
    }
    
    func printReport() {
        print("Doctors' details : ")
        for doctor in arrayOfDoctors {
            print("Name: \(doctor.name), ID: \(doctor.id), Specialization: \(doctor.specialization), Number of appointments: In AM -\(doctor.availability.am), In PM - \(doctor.availability.pm)")
            print("")
        }
        
        print("Patients' details : ")
        for patient in arrayOfPatients {
            print("Name: \(patient.name), ID: \(patient.id), Mobie number: \(patient.mobileNumber), Age: \(patient.age)")
        }
    }
    
}//end class CliniqueManager
