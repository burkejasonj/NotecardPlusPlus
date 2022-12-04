import SwiftUI
import Foundation

enum ActiveSheet: Identifiable {
    case classCreator, classImporter
    
    var id: Int {
        hashValue
    }
}

struct ContentView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        entity: Class.entity(),
        sortDescriptors:
            [NSSortDescriptor(keyPath: \Class.order, ascending: true)],
        animation: .default
    )
    private var classes: FetchedResults<Class>
    
    @State private var showSheet: ActiveSheet? = nil
    
    @State private var selection: Class?
    
    var body: some View {
        NavigationSplitView {
            List(selection: $selection) {
                ForEach(Array(classes)) { thisClass in
                    NavigationLink(value: thisClass) {
                        ClassRowView(classInfo: thisClass)
                    }
                }
                .onMove(perform: moveItem)
                .onDelete(perform: deleteItem)
            }
            .listStyle(.sidebar)
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Menu {
                        Button("New Class") {
                            showSheet = .classCreator
                        }
                        Button("Import Class") {
                            showSheet = .classImporter
                        }
                    } label: {
                        Label("Add...", systemImage: "plus")
                            .labelStyle(.iconOnly)
                    }
                    .menuStyle(.borderlessButton)
                }
            }
            .sheet(item: $showSheet) { sheetType in
                switch sheetType {
                case .classCreator:
                    ClassCreatorView()
                case .classImporter:
                    ClassImporterView()
                }
            }
        } detail: {
            if let thisClass = selection {
                ClassDetailView(classInfo: thisClass)
            } else {
                Text("No Class Selected")
                    .font(.largeTitle)
                    .foregroundColor(Color.secondary)
            }
        }
    }
    
    private func moveItem(at source: IndexSet, to destination: Int) {
        if source.first! > destination {
            classes[source.first!].order = classes[destination].order - 1
            for i in destination...classes.count - 1 {
                classes[i].order = classes[i].order + 1
            }
        }
        if source.first! < destination {
            classes[source.first!].order = classes[destination - 1].order + 1
            for i in 0...destination - 1 {
                classes[i].order = classes[i].order - 1
            }
        }
        do {
            try viewContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func deleteItem(at offset: IndexSet) {
        withAnimation {
            offset.map { i in
                classes[i]
            }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(
                \.managedObjectContext,
                 PersistenceController.preview.container.viewContext
            )
    }
}
