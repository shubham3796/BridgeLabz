class Server : ComputerProtocol{
    var system = System(cost: 0.00,company: "abc")
    init(_ system: System) {
        self.system.cost = 30000.0
        self.system.company = "microsoft"
    }
    func printSystemDetails() {
        print("This is a Server manufactured by \(system.company), worth Rs.\(system.cost)")
    }
}
