import SwiftUI

struct ClassImporterView: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationView {
            Text("ClassImporterView")
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            dismiss()
                        } label: {
                            Text("Cancel")
                        }
                    }
                }
                .navigationTitle("Import Class")
        }
    }
}

struct ClassImporterView_Previews: PreviewProvider {
    static var previews: some View {
        ClassImporterView()
    }
}
