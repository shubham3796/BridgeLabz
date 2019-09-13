class Laptop : ComputerProtocol {
    var system = System(cost: 0.00,company: "abc")
    init(_ system : System) {
        self.system.cost = 50000.00
        self.system.company = "dell"
    }
    func printSystemDetails() {
        print("This is a Laptop manufactured by \(system.company), worth Rs.\(system.cost)")
    }
}
