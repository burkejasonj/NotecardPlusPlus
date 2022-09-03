import SwiftUI

@main
struct NotecardPlusPlusApp: App {
    let persistenceController = PersistenceControllerV2.preview

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(
                    \.managedObjectContext,
                    persistenceController.container.viewContext
                )
        }
    }
}
