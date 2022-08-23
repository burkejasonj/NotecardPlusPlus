import SwiftUI

struct ClassCreatorView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State var classNameString = ""
    @State var classLevelString = ""
    @ObservedObject var classYearInt = NumberInput()
    @State var classColor: Color = .accentColor
    
    @FocusState var focusState: String?
    
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        NavigationView {
            Group {
                Form {
                    Section("ATTRIBUTES") {
                        TextField("Name",
                                  text: $classNameString,
                                  prompt: Text("Class Name")
                        )
                        .focused($focusState, equals: "name")
                        .onSubmit {
                            focusState = "level"
                        }
                        TextField("Level",
                                  text: $classLevelString,
                                  prompt: Text("Class Level")
                        )
                        .focused($focusState, equals: "level")
                        .onSubmit {
                            focusState = "year"
                        }
                        TextField("Year",
                                  text: $classYearInt.value,
                                  prompt: Text("Class Year")
                        )
                        .keyboardType(.numberPad)
                        .focused($focusState, equals: "year")
                        ColorPicker(selection: $classColor, supportsOpacity: false) {
                            Text("Class Color")
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
                .toolbar() {
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

struct ClassCreatorView_Previews: PreviewProvider {
    static var previews: some View {
        ClassCreatorView()
    }
}
