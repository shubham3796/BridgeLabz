struct ComputerFactory {
    
    var system:System
    init(_ system:System){
        self.system = system
    }
    static func createSystem(_ type:Int)->ComputerProtocol {
        switch type {
        case 1 :
            return Pc(System(cost: 0.00,company: "abc"))
        case 2 :
            return Laptop(System(cost: 0.00,company: "abc"))
        default:
            print("Enter valid system type. Returning PC")
            return Pc(System(cost: 0.00,company: "abc"))
        }
    }
    
}
