protocol Observer {
    var name:String {get set}
    
    func getUpdate(_ message:String)//update()
}
