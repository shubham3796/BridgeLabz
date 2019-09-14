class MyTopicSubscriber : Observer {
    var name:String
    var topic:Topic
    func getUpdate(_ message:String)//update()
    {
        self.topic.message = message
    }
    init(_ name:String,_ message:String) {
        self.name = name
        self.topic=Topic("Dummy message")
        self.topic = self.topic.register(self)
    }
}
