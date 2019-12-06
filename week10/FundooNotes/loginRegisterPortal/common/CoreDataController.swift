
import UIKit
import CoreData

class CoreDataController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    static func deleteCoreData(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return}
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        var title = 1
        while title<10 {
            let previousTitle = "\(title)"
            print("Deleted \(title) from core data")
            
            fetchRequest.predicate = NSPredicate(format: "title = %@",previousTitle)
            
            do{
                let test = try managedContext.fetch(fetchRequest)
                if test.count > 0 {
                    let ObjectToDelete = test[0] as! NSManagedObject
                    managedContext.delete(ObjectToDelete)
                }
                do {
                    try managedContext.save()
                }
                catch {
                    print("Error 3")
                }
            }
            catch{
                print("Error 4")
            }
            
            title+=1
        }
    }
    
    static func deleteWholeCoreData() {
        
        let appDel:AppDelegate = (UIApplication.shared.delegate as! AppDelegate)
        let context:NSManagedObjectContext = appDel.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        fetchRequest.returnsObjectsAsFaults = false
        
        do
        {
            let results = try context.fetch(fetchRequest)
            for managedObject in results
            {
                let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
                context.delete(managedObjectData)
            }
        } catch let error as NSError {
            print("Deleted all my data in myEntity error : \(error) \(error.userInfo)")
        }
    }
    

}
