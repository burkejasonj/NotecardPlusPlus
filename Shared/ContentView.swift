import CoreData
import Foundation
import SwiftUI

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

    //private let userInterfaceIdiom = UIDevice.current.userInterfaceIdiom

    @State private var showSheet: ActiveSheet? = nil

    @State private var selection: UUID?
    
    var body: some View {
        NavigationSplitView {
            List {
                ForEach(Array(classes)) { thisClass in
                    Button {
                        selection = thisClass.uuid
                    } label: {
                        ClassRowView(classInfo: thisClass)
                    }
#if os(macOS)
                    .buttonStyle(listButtonStyle(tint: Color.accentColor))
#endif
                }
                .onMove(perform: moveItem)
                .onDelete(perform: deleteItem)
            }
            .listStyle(.sidebar)
            .toolbar {
                ToolbarItemGroup(placement: .primaryAction) {
                    EditButton()
                    Menu {
                        NavigationLink(value: "New Class") {
                            Text("New Class")
                        }
                        NavigationLink(value: "Import Class") {
                            Text("Import Class")
                        }
                    } label: {
                        Label("Layout Options", systemImage: "plus")
                            .labelStyle(.iconOnly)
                    }
                    .menuStyle(.borderlessButton)
                }
            }
            .navigationSplitViewColumnWidth(ideal: 200.0)
        } detail: {
            if let classUUID = selection {
                ClassDetailView(
                    classInfo: ExchangeV2getClassbyUUID(
                        classUUID,
                        viewContext
                    )
                )
            } else {
                Text("No Class Selected")
                    .font(.largeTitle)
                    .foregroundColor(Color.secondary)
            }
        }
//        NavigationView {
//            List {
//                ForEach(Array(classes)) { thisClass in
//                    NavigationLink(
//                        destination: ClassDetailView(classInfo: thisClass)
//                    ) {
//                        ClassRowView(classInfo: thisClass)
//                            .padding(
//                                .vertical,
//                                userInterfaceIdiom == .mac ? 8 : 0
//                            )
//                    }
//                }
//                .onMove(perform: moveItem)
//                .onDelete(perform: deleteItem)
//            }
//            .listStyle(.sidebar)
//            .accentColor(.init(UIColor.secondarySystemFill))
//            .toolbar {
//                ToolbarItem(placement: .navigationBarLeading) {
//                    Button {
//                        UserDefaults.standard.set(false, forKey: "isPreloaded")
//                    } label: {
//                        Text("Fix All")
//                    }
//                }
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    EditButton()
//                }
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    Menu {
//                        Button {
//                            showSheet = .classCreator
//                        } label: {
//                            Text("Create Class")
//                        }
//
//                        Button {
//                            showSheet = .classImporter
//                        } label: {
//                            Text("Import Class")
//                        }
//                    } label: {
//                        Image(systemName: "plus")
//                    }
//                    .menuStyle(.borderlessButton)
//                }
//            }
//            .sheet(item: $showSheet) { sheet in
//                switch sheet {
//                case .classCreator:
//                    ClassCreatorView()
//                case .classImporter:
//                    ClassImporterView()
//                }
//            }
//            .navigationTitle("Classes")
//
//            Text("No Class Selected")
//                .font(.largeTitle)
//                .foregroundColor(Color(UIColor.secondaryLabel))
//                .navigationTitle("Details")
//        }
//        .ifCondition(userInterfaceIdiom != .phone, then: { nv in
//            nv.navigationViewStyle(.columns)
//        }, else: { nv in
//            nv.navigationViewStyle(.stack)
//        })
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
