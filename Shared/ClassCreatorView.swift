import SwiftUI

struct ClassCreatorView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State private var classNameString = ""
    @State private var classLevelString = ""
    @ObservedObject var classYearInt = NumberInput()
    
    @FocusState var focusState: String?
    
    var body: some View {
        NavigationView {
            Group {
                Form {
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
                }
            }
                .toolbar() {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            dismiss()
                        } label: {
                            Text("Cancel")
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
