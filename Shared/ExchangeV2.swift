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
