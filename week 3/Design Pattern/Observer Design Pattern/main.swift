import Foundation

var topic = Topic("This is the first message.")
var subscriber1 = MyTopicSubscriber("Ravindra",topic.message!)
var subscriber2 = MyTopicSubscriber("Sudipto",topic.message!)
var subscriber3 = MyTopicSubscriber("Vishnu",topic.message!)

print("TOPIC : \(topic.message!)")
print("SUBSCRIBER 1: \(subscriber1.topic.message!)")
print("SUBSCRIBER 2: \(subscriber1.topic.message!)")
print("SUBSCRIBER 3: \(subscriber1.topic.message!)")
print("")


topic.update("This is the modified message")


print("TOPIC : \(topic.message!)")
print("SUBSCRIBER 1: \(subscriber1.topic.message!)")
print("SUBSCRIBER 2: \(subscriber1.topic.message!)")
print("SUBSCRIBER 3: \(subscriber1.topic.message!)")
