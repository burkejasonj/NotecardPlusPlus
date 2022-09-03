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
                    
                    print("found item of type \(type ?? "UNKNOWN") with uuid \(uuid ?? "UNKNOWN")")
                }
            }
        }
    }
}
