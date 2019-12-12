
import UIKit
import UserNotifications

class LocalNotificationController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    static func triggerLocalNotification(_ dateComponents:DateComponents,_ note:oneNote){
        let center = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent()
        content.title = note.oneTitle!
        content.body = note.reminderDateTimeInfo
        content.sound = .default
        content.userInfo = ["value": note.note]
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        let request = UNNotificationRequest(identifier: "reminder", content: content, trigger: trigger)
        
        center.add(request){ (error) in
            if error != nil {
                print("Error = \(error?.localizedDescription ?? "error local notification")")
            }
        }
    }
}
