// Another implementation of singleton design pattern with eager initialization.
//No seperate function to access instance of class. It is public, and created the first time it is accessed.
class NetworkManager2 {
    public static let instanceOfNetworkManager2 = NetworkManager2()
    var internetAvailability = false
    private init(){
    }
}
