class Topic : Subject {
    private var listOfObservers : [MyTopicSubscriber]
    var message : String?
    private var changed : Bool
    func register(_ subscriber:Observer) -> Topic{
        listOfObservers.append(subscriber as! MyTopicSubscriber)
        return topic
    }
    func deregister(_ subscriber:Observer){
        var i=0
        var index=0
        for anObserver in listOfObservers {
            if anObserver.name == subscriber.name {
                index = i
            }
            i += 1
        }
        listOfObservers.remove(at: index)
    }
    func notifyObservers(){
        for observer in listOfObservers{
            observer.getUpdate(message!)
        }
        changed = false
    }
    func sendUpdate()->String//getUpdate()
    {
        return message!
    }
    func update(_ newMessage : String){
        self.message = newMessage
        self.changed = true
        self.notifyObservers()
    }
    init(_ message:String) {
        self.listOfObservers = [MyTopicSubscriber]()
        self.message = message
        self.changed = false
        // register(name)
    }
}
