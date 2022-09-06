import CoreData
import Foundation
import SwiftUI

func ExchangeV2import(file json: Any?, viewContext: NSManagedObjectContext) {
    if let file = json as? [String: Any] {
        let version = file["version"] as? Int64
        let contentType = file["content-type"] as? String
        
        print("version \(version ?? -1)")
        print("content-type \(contentType ?? "unknown")")
        
        if let content = file["content"] as? [Any] {
            // PASS 1: Import Attributes
            for i in content {
                if let item = i as? [String: Any] {
                    let type = item["type"] as? String
                    let uuid = item["uuid"] as? String
                    
                    switch type {
                    case "SCHOOL":
                        ExchangeV2parseSchoolAttributes(item, viewContext)
                    case "TEACHER":
                        ExchangeV2parseTeacherAttributes(item, viewContext)
                    case "CREATOR":
                        ExchangeV2parseCreatorAttributes(item, viewContext)
                    case "CLASS":
                        ExchangeV2parseClassAttributes(item, viewContext)
                    default:
                        print("unable to handle item \(uuid ?? "UNKNOWN")")
                    }
                }
            }
            
//            do {
//                try viewContext.save()
//            } catch {
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
            
            // PASS 2: Relationships
            
            for i in content {
                if let item = i as? [String: Any] {
                    let type = item["type"] as? String
                    let uuid = item["uuid"] as? String
                    
                    switch type {
//                    case "SCHOOL":
//                        ExchangeV2parseSchoolRelationships(item, viewContext)
//                    case "TEACHER":
//                        ExchangeV2parseTeacherRelationships(item, viewContext)
//                    case "CREATOR":
//                        ExchangeV2parseCreatorRelationships(item, viewContext)
                    case "CLASS":
                        ExchangeV2parseClassRelationships(item, viewContext)
                    default:
                        print("unable to handle item \(uuid ?? "UNKNOWN")")
                    }
                }
            }
            
        }
    }
}

func ExchangeV2parseSchoolAttributes(
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

//func ExchangeV2parseSchoolRelationships (
//    _ item: [String: Any],
//    _ viewContext: NSManagedObjectContext
//) {
//    let type = item["type"] as? String
//    let uuid = item["uuid"] as? String
//    let name = item["name"] as? String
//    let teachers = item["teachers"] as? [String]
//
//    print("parse object of type \(type ?? "UNKNOWN") with uuid \(uuid ?? "UNKNOWN")")
//    print("object has name \(name ?? "UNKNOWN")")
//    print("object contains the following teachers \(teachers ?? ["UNKNOWN"])")
//
//    let schoolRequest = School.fetchRequest() as NSFetchRequest<School>
//    schoolRequest.predicate = NSPredicate(format: "uuid == %@", argumentArray: [UUID(uuidString: uuid ?? "") ?? UUID()])
//    let school = try? viewContext.fetch(schoolRequest)
//
//    let teachersRequest = Teacher.fetchRequest() as NSFetchRequest<Teacher>
//    teachersRequest.predicate = NSPredicate(
//        format: "uuid == %@",
//        argumentArray: teachers
//    )
//    let importedTeachers = try? viewContext.fetch(teachersRequest)
//
//    // TODO: REMOVE DEBUG
//    if school!.isEmpty {
//        fatalError("PASS 1 FAILED: MISSING SCHOOL UUID \(uuid ?? "UNKNOWN")")
//    }
//    if importedTeachers!.isEmpty {
//        fatalError("PASS 1 FAILED: MISSING TEACHER UUID \(uuid ?? "UNKNOWN")")
//    }
//
//    for teacher in importedTeachers!
//    {
//        teacher.school = school!.first!
//    }
//}

func ExchangeV2parseTeacherAttributes(
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



func ExchangeV2parseTeacherRelationships (
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

    let teacherFetchRequest = NSFetchRequest<Teacher>(
        entityName: "Teacher"
    )
    teacherFetchRequest.predicate = NSPredicate(
        format: "uuid == %@",
        argumentArray: [UUID(uuidString: uuid ?? "") ?? UUID()]
    )
    
    let teacherSchoolFetchRequest = NSFetchRequest<School>(
        entityName: "School"
    )
    teacherSchoolFetchRequest.predicate = NSPredicate(
        format: "uuid == %@",
        argumentArray: [UUID(uuidString: school ?? "") ?? UUID()]
    )
    
    do {
        let teacher = try viewContext.fetch(teacherFetchRequest)
        let teacherSchool = try viewContext.fetch(teacherSchoolFetchRequest)
        
        teacher.first!.school = teacherSchool.first!
        
    } catch {
        fatalError("ERROR FETCHING DATA")
    }
}

func ExchangeV2parseCreatorAttributes(
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

func ExchangeV2parseClassAttributes(
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
    
    let newClass = Class(context: viewContext)
    
    newClass.name = name ?? "Unknown Class"
    newClass.level = level ?? ""
    newClass.color = color ?? "5856D6"
    newClass.uuid = UUID(uuidString: uuid ?? UUID().uuidString)
    newClass.year = Int64(year ?? "0") ?? 0
    newClass.order = order ?? 0
}

func ExchangeV2parseClassRelationships(
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

    let thisClassFetchRequest = NSFetchRequest<Class>(
        entityName: "Class"
    )
    thisClassFetchRequest.predicate = NSPredicate(
        format: "uuid == %@",
        argumentArray: [UUID(uuidString: uuid ?? "") ?? UUID()]
    )

    let classTeacherFetchRequest = NSFetchRequest<Teacher>(
        entityName: "Teacher"
    )
    classTeacherFetchRequest.predicate = NSPredicate(
        format: "uuid == %@",
        argumentArray: [UUID(uuidString: teacher ?? "") ?? UUID()]
    )

    let classCreatorFetchRequest = NSFetchRequest<Creator>(
        entityName: "Creator"
    )
    classCreatorFetchRequest.predicate = NSPredicate(
        format: "uuid == %@",
        argumentArray: [UUID(uuidString: creator ?? "") ?? UUID()]
    )

    do {
        let thisClass = try viewContext.fetch(thisClassFetchRequest)
        let classTeacher = try viewContext.fetch(classTeacherFetchRequest)
        let classCreator = try viewContext.fetch(classCreatorFetchRequest)

        let newCreator = Creator(context: viewContext)

        thisClass.first!.teacher = classTeacher.first!
        thisClass.first!.creator = classCreator.first!
    } catch {
        fatalError("ERROR FETCHING DATA")
    }

}

