import Foundation
import SwiftUI

struct BookHeroLabelView: View {
    var title: String
    var level: String
    var teacher: String
    var creator: String
    var school: String

    var body: some View {
        VStack(alignment: .leading) {
            Group {
                Text(title)
                    .fontWeight(Font.Weight.semibold)
                    .font(.title)
                Text(level)
                    .font(.title2)
            }
            .foregroundColor(Color.primary)
            Group {
                Text(teacher)
                Text("Provided by \(creator)")
                Text(school)
            }
            .font(.title3)
            .foregroundColor(Color.secondary)
        }
    }
}

struct BookHeroLabelView_Previews: PreviewProvider {
    static var previews: some View {
        BookHeroLabelView(
            title: "Algebra 2",
            level: "Honors",
            teacher: "Unknown Instructor",
            creator: "Notecard++",
            school: "BCHS")
    }
}
