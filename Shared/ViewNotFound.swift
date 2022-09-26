import SwiftUI

struct ViewNotFound: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationView {
            Text("I can't find the view you're looking for.")
                .toolbar {
                    ToolbarItem {
                        Button {
                            dismiss()
                        } label: {
                            Text("Cancel")
                        }
                    }
                }
                .navigationTitle("404: View not Found")
        }
    }
}

struct ViewNotFound_Previews: PreviewProvider {
    static var previews: some View {
        ViewNotFound()
    }
}
