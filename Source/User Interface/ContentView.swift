import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationSplitView {
            Text("Content")
        } detail: {
            Text("Detail")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
