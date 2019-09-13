class Pc : ComputerProtocol{
    var system = System(cost: 0.00,company: "abc")
    init(_ system: System) {
        self.system.cost = 40000.0
        self.system.company = "hp"
    }
    func printSystemDetails() {
        print("This is a PC manufactured by \(system.company), worth Rs.\(system.cost)")
    }
}
