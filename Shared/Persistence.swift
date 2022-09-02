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
                forResource: "TestData",
                ofType: "json"
            ) // file path for file "data.txt"
            let inputString = try? String(
                contentsOfFile: path!,
                encoding: String.Encoding.utf8
            )
            
            let json = try? JSONSerialization
                .jsonObject(
                    with: Data(inputString?.utf8 ?? "{}".utf8),
                    options: []
                )
            
            if let importedData = json as? [String: Any] {
                let type = importedData["type"] as? String
                let uuid = importedData["uuid"] as? String
                let name = importedData["name"] as? String
                
                let newSchool = School(context: viewContext)
                
                newSchool.name = name ?? "Unknown School"
                newSchool.uuid = UUID(uuidString: uuid ?? UUID().uuidString)
                
                if let teachers = importedData["teachers"] as? [Any] {
                    for t in teachers {
                        if let teacher = t as? [String: Any] {
                            let type = teacher["type"] as? String
                            let uuid = teacher["uuid"] as? String
                            let name = teacher["name"] as? String
                            
                            let newTeacher = Teacher(context: viewContext)
                            
                            newTeacher.name = name ?? "Unknown Instructor"
                            newTeacher.uuid = UUID(
                                uuidString: uuid ?? UUID().uuidString
                            )
                            newTeacher.school = newSchool
                            
                            if let classes = teacher["classes"] as? [Any] {
                                var order: Int64 = 0
                                for c in classes {
                                    if let thisClass = c as? [String: Any] {
                                        let type = thisClass["type"] as? String
                                        let uuid = thisClass["uuid"] as? String
                                        let name = thisClass["name"] as? String
                                        let level = thisClass["level"] as? String
                                        let year = thisClass["year"] as? String
                                        let color = thisClass["color"] as? String
                                        let order = thisClass["order"] as? Int64
                                        
                                        let newClass = Class(context: viewContext)
                                        
                                        newClass.name = name ?? "Unknown Class"
                                        newClass.level = level ?? ""
                                        newClass.color = color ?? "5856D6"
                                        newClass.uuid = UUID(uuidString: uuid ?? UUID().uuidString)
                                        newClass.year = Int64(year ?? "0") ?? 0
                                        newClass.order = order ?? 0
                                        newClass.teacher = newTeacher
                                        
                                        if let creator = thisClass["creator"] as? [String: Any] {
                                            let type = creator["type"] as? String
                                            let uuid = creator["uuid"] as? String
                                            let name = creator["name"] as? String
                                            
                                            let id = UUID(uuidString: uuid ?? "") ?? UUID()
                                            
                                            let request = Creator.fetchRequest() as NSFetchRequest<Creator>
                                            request.predicate = NSPredicate(format: "%K == %@", "uuid", id as CVarArg)
                                            let items = try? viewContext.fetch(request)
                                            
                                            if items?.count == 0 {
                                                let newCreator = Creator(context: viewContext)
                                                
                                                newCreator.name = name ?? "Notecard++"
                                                newCreator.uuid = UUID(uuidString: uuid ?? UUID().uuidString)
                                                
                                                newClass.creator = newCreator
                                            } else {
                                                newClass.creator = items?.first
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            
            let newQuestion = Question(context: viewContext)
            
            newQuestion.question = "What value does i represent?"
            newQuestion.answer = "sqrt(-1),sqrt(-2),sqrt(-3),sqrt(-4)"
            newQuestion.uuid = UUID()
            newQuestion.type = "MULTICHOICE"
            
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
