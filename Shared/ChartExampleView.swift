import SwiftUI
import Foundation

struct ChartExampleView: View {
    var accentColor: Color = .indigo
    var body: some View {
        HStack {
            VStack(alignment: .trailing) {
                Text("1. You")
                    .foregroundColor(accentColor)
                    .frame(height: 25)
                Text("2. Someone Else")
                    .frame(height: 25)
                Text("3. Someone Else")
                    .frame(height: 25)
                Text("4. Someone Else")
                    .frame(height: 25)
                Text("5. Someone Else")
                    .frame(height: 25)
                Text("6. Someone Else")
                    .frame(height: 25)
            }
            VStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 8)
                    .fill(accentColor)
                    .frame(maxWidth: 200, maxHeight: 25)
                RoundedRectangle(cornerRadius: 8)
                    .fill(accentColor)
                    .frame(maxWidth: 188, maxHeight: 25)
                RoundedRectangle(cornerRadius: 8)
                    .fill(accentColor)
                    .frame(maxWidth: 175, maxHeight: 25)
                RoundedRectangle(cornerRadius: 8)
                    .fill(accentColor)
                    .frame(maxWidth: 167, maxHeight: 25)
                RoundedRectangle(cornerRadius: 8)
                    .fill(accentColor)
                    .frame(maxWidth: 150, maxHeight: 25)
                RoundedRectangle(cornerRadius: 8)
                    .fill(accentColor)
                    .frame(maxWidth: 150, maxHeight: 25)
            }
        }
    }
}

struct ChartExampleView_Previews: PreviewProvider {
    static var previews: some View {
        ChartExampleView()
    }
}
