
import Foundation

let object = NetworkManager.getNetworkObject()
print("internetAvaialability of network 1= \(object.internetAvailability)")
object.internetAvailability = false
print("New internetAvaialability of network 1= \(object.internetAvailability)")

print("internetAvaialability of network 2 = \(NetworkManager2.instanceOfNetworkManager2.internetAvailability)")
NetworkManager2.instanceOfNetworkManager2.internetAvailability = true
print("New internetAvaialability of network 2 = \(NetworkManager2.instanceOfNetworkManager2.internetAvailability)")
