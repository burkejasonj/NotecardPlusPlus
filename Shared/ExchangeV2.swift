import CoreData
import Foundation

func ExchangeV2import(file json: Any?, viewContext: NSManagedObjectContext) {
    if let file = json as? [String: Any] {
        let version = file["version"] as? Int64
        let contentType = file["content-type"] as? String
        
        print("version \(version ?? -1)")
        print("content-type \(contentType ?? "unknown")")
        
        if let content = file["content"] as? [Any] {
            for i in content {
                if let item = i as? [String: Any] {
                    let type = item["type"] as? String
                    let uuid = item["uuid"] as? String
                    
                    switch type {
                    case "SCHOOL":
                        ExchangeV2parseSchoolItem(item, viewContext)
                    case "TEACHER":
                        ExchangeV2parseTeacherItem(item, viewContext)
                    case "CREATOR":
                        ExchangeV2parseCreatorItem(item, viewContext)
                    case "CLASS":
                        ExchangeV2parseClassItem(item, viewContext)
                    default:
                        print("unable to handle item \(uuid ?? "UNKNOWN")")
                    }
                }
            }
        }
    }
}

func ExchangeV2parseSchoolItem(
    _ item: [String: Any],
    _ viewContext: NSManagedObjectContext
) {
    let type = item["type"] as? String
    let uuid = item["uuid"] as? String
    let name = item["name"] as? String
    let teachers = item["teachers"] as? [String]
    
    print("parse object of type \(type ?? "UNKNOWN") with uuid \(uuid ?? "UNKNOWN")")
    print("object has name \(name ?? "UNKNOWN")")
    print("object contains the following teachers \(teachers ?? ["UNKNOWN"])")
    
    let newSchool = School(context: viewContext)
    
    newSchool.name = name ?? "Unknown School"
    newSchool.uuid = UUID(uuidString: uuid ?? UUID().uuidString)
}

func ExchangeV2parseTeacherItem(
    _ item: [String: Any],
    _ viewContext: NSManagedObjectContext
) {
    let type = item["type"] as? String
    let uuid = item["uuid"] as? String
    let name = item["name"] as? String
    let school = item["school"] as? String
    let classes = item["classes"] as? [String]
    
    print("parse object of type \(type ?? "UNKNOWN") with uuid \(uuid ?? "UNKNOWN")")
    print("object has name \(name ?? "UNKNOWN")")
    print("object has school \(school ?? "UNKNOWN")")
    print("object contains the following classes \(classes ?? ["UNKNOWN"])")
    
    let newTeacher = Teacher(context: viewContext)
    
    newTeacher.name = name ?? "Unknown Instructor"
    newTeacher.uuid = UUID(
        uuidString: uuid ?? UUID().uuidString
    )
}

func ExchangeV2parseCreatorItem(
    _ item: [String: Any],
    _ viewContext: NSManagedObjectContext
) {
    let type = item["type"] as? String
    let uuid = item["uuid"] as? String
    let name = item["name"] as? String
    let classes = item["classes"] as? [String]
    
    print("parse object of type \(type ?? "UNKNOWN") with uuid \(uuid ?? "UNKNOWN")")
    print("object has name \(name ?? "UNKNOWN")")
    print("object contains the following classes \(classes ?? ["UNKNOWN"])")
    
    let newCreator = Creator(context: viewContext)
    
    newCreator.name = name ?? "Unknown Instructor"
    newCreator.uuid = UUID(
        uuidString: uuid ?? UUID().uuidString
    )
}

func ExchangeV2parseClassItem(
    _ item: [String: Any],
    _ viewContext: NSManagedObjectContext
) {
    let type = item["type"] as? String
    let uuid = item["uuid"] as? String
    let name = item["name"] as? String
    let level = item["level"] as? String
    let year = item["year"] as? String
    let color = item["color"] as? String
    let order = item["order"] as? Int64
    let teacher = item["teacher"] as? String
    let creator = item["creator"] as? String
    
    print("parse object of type \(type ?? "UNKNOWN") with uuid \(uuid ?? "UNKNOWN")")
    print("object has name \(name ?? "UNKNOWN")")
    print("object has level \(level ?? "UNKNOWN")")
    print("object has year \(year ?? "UNKNOWN")")
    print("object has color \(color ?? "UNKNOWN")")
    print("object has order \(order ?? -1)")
    print("object has teacher \(teacher ?? "UNKNOWN")")
    print("object has creator \(creator ?? "UNKNOWN")")
}

