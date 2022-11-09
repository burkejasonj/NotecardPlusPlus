import CoreData
import Foundation

struct PersistenceController {
    static let shared = PersistenceController()
    
    static var preview: PersistenceController = {
        let result = PersistenceController()
        let viewContext = result.container.viewContext
        
        let defaults = UserDefaults.standard
        
        // Preload start
        if defaults.bool(forKey: "isPreloaded") == false {
            defaults.set(true, forKey: "isPreloaded")
            
            let path = Bundle.main.path(
                forResource: "TestDataV2",
                ofType: "json"
            )
            
            let inputString = try? String(
                contentsOfFile: path!,
                encoding: String.Encoding.utf8
            )
            
            let json = try? JSONSerialization
                .jsonObject(
                    with: Data(inputString?.utf8 ?? "{}".utf8),
                    options: []
                )
            
            // ExchangeV2 Import
            ExchangeV2import(
                file: json,
                viewContext: viewContext
            )
            
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
        
        return result
    }()
    
    let container: NSPersistentCloudKitContainer
    
    init(inMemory: Bool = false) {
        container = NSPersistentCloudKitContainer(name: "NotecardPlusPlus")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(
                fileURLWithPath: "/dev/null"
            )
        }
        container.loadPersistentStores(completionHandler: { _, error in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
