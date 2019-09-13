//Eager initialization in singleton design pattern with a public function to access the instance of class
class NetworkManager {
    private static let instanceOfNetworkManager = NetworkManager()
    var internetAvailability = true//aditional variable
    private init() {
    }
    public static func getNetworkObject() -> NetworkManager {
        return instanceOfNetworkManager
    }
}

