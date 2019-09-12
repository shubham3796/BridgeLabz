class Doctor {
    var name : String
    var id : String
    var specialization : String
    var availability : Availability
    
    init(_ name:String,_ id:String,_ specialization:String){
        self.name=name
        self.id = id
        self.specialization = specialization
        self.availability = Availability()
    }
    
}
