import SwiftUI

#if os(macOS)
struct ClassCreatorView: View {
    @Environment(\.dismiss) var dismiss
    
    @State var classNameString = ""
    @State var classLevelString = ""
    @ObservedObject var classYearInt = NumberInput()
    @State var classColor: Color = .accentColor
    
    @FocusState var focusState: String?
    
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        NavigationStack {
            Group {
                Form {
                    TextField("Name:",
                              text: $classNameString)
                    .focused($focusState, equals: "name")
                    .onSubmit {
                        focusState = "level"
                    }
                    TextField("Level:",
                              text: $classLevelString)
                    .focused($focusState, equals: "level")
                    .onSubmit {
                        focusState = "year"
                    }
                    TextField("Year:",
                              text: $classYearInt.value)
                    .focused($focusState, equals: "year")
                    ColorPicker(
                        "Color:",
                        selection: $classColor,
                        supportsOpacity: false
                    )
                    ClassRowView(
                        accentColor: classColor,
                        title: classNameString,
                        level: classLevelString
                    )
                }
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel")
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        let thisClass = Class(context: viewContext)
                        
                        thisClass.name = classNameString
                        thisClass.level = classLevelString
                        thisClass.color = classColor.toHex()
                        thisClass.uuid = UUID()
                        thisClass.year = Int64(classYearInt.value) ?? 2022
                        thisClass.order = 0
                        
                        do {
                            try viewContext.save()
                        } catch {
                            print("error")
                        }
                        
                        dismiss()
                    } label: {
                        Text("Create")
                    }
                }
            }
            .navigationTitle("Create Class")
        }
        .padding()
    }
}
#else
struct ClassCreatorView: View {
    @Environment(\.dismiss) var dismiss
    
    @State var classNameString = ""
    @State var classLevelString = ""
    @ObservedObject var classYearInt = NumberInput()
    @State var classColor: Color = .accentColor
    
    @FocusState var focusState: String?
    
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        NavigationStack {
            Group {
                Form {
                    Section("ATTRIBUTES") {
                        TextField("",
                                  text: $classNameString,
                                  prompt: Text("Name"))
                            .focused($focusState, equals: "name")
                            .onSubmit {
                                focusState = "level"
                            }
                        TextField("",
                                  text: $classLevelString,
                                  prompt: Text("Level"))
                            .focused($focusState, equals: "level")
                            .onSubmit {
                                focusState = "year"
                            }
                        TextField("",
                                  text: $classYearInt.value,
                                  prompt: Text("Year"))
#if os(iOS)
                            .keyboardType(.numberPad)
#endif
                            .focused($focusState, equals: "year")
                        ColorPicker(selection: $classColor, supportsOpacity: false) {
                            Text("Color")
                        }
                    }
                    Section("PREVIEW") {
                        VStack {
                            ClassRowView(
                                accentColor: classColor,
                                title: classNameString,
                                level: classLevelString
                            )
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel")
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        let thisClass = Class(context: viewContext)
                            
                        thisClass.name = classNameString
                        thisClass.level = classLevelString
                        thisClass.color = classColor.toHex()
                        thisClass.uuid = UUID()
                        thisClass.year = Int64(classYearInt.value) ?? 2022
                        thisClass.order = 0
                            
                        do {
                            try viewContext.save()
                        } catch {
                            print("error")
                        }
                            
                        dismiss()
                    } label: {
                        Text("Create")
                    }
                }
            }
            .navigationTitle("Create Class")
        }
    }
}
#endif

struct ClassCreatorView_Previews: PreviewProvider {
    static var previews: some View {
        ClassCreatorView()
    }
}
