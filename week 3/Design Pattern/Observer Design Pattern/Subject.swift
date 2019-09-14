protocol Subject {
    func register(_ subscriber:Observer) -> Topic
    func deregister(_ subscriber:Observer)
    func notifyObservers()
    func sendUpdate()->String//getUpdate()
    func update(_ newMessage : String)
}
