import Foundation
import SwiftUI

struct ClassDetailView: View {
    var accentColor: Color

    var title: String
    var level: String
    var teacher: String
    var creator: String
    var school: String

    var scale: CGFloat = 1

    var gradient: Gradient {
        Gradient(colors: [accentColor, Color.clear])
    }

    @Environment(\.horizontalSizeClass) var sizeClass

    init(
        accentColor: Color,
        title: String,
        level: String,
        teacher: String,
        creator: String,
        school: String
    ) {
        self.accentColor = accentColor
        self.title = title
        self.level = level
        self.teacher = teacher
        self.creator = creator
        self.school = school
    }

    init(classInfo: Class?) {
        self.accentColor = Color(hex: classInfo?.color) ?? Color.accentColor
        self.title = classInfo?.name ?? "Unknown Class"
        self.level = classInfo?.level ?? ""
        self.teacher = classInfo?.teacher?.name ?? "Unknown Instructor"
        self.creator = classInfo?.creator?.name ?? "Unknown Provider"
        self.school = classInfo?.teacher?.school?.name ?? ""
    }

    var body: some View {
        GeometryReader { geo in
            if sizeClass == .compact {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading) {
                        BookHeroView(
                            accentColor: accentColor,
                            size: min(
                                geo.size.height - 144.3,
                                geo.size.width
                            ),
                            gradient: gradient
                        )
                        BookHeroLabelView(
                            title: title,
                            level: level,
                            teacher: teacher,
                            creator: creator,
                            school: school
                        )
                        ChartExampleView(accentColor: accentColor)
                    }
                    .frame(width: min(
                        geo.size.height - 144.3,
                        geo.size.width
                    ) * 0.75)
                }
                .frame(maxWidth: .infinity, alignment: .center)
            } else {
                HStack(alignment: .top) {
                    BookHeroView(
                        accentColor: accentColor,
                        size: min(geo.size.height - 66.3, 400),
                        gradient: gradient
                    )
                    ScrollView {
                        VStack(alignment: .leading) {
                            BookHeroLabelView(
                                title: title,
                                level: level,
                                teacher: teacher,
                                creator: creator,
                                school: school
                            )
                            ChartExampleView(accentColor: accentColor)
                        }
                    }
                }
                .padding(
                    .horizontal,
                    UIDevice.current.userInterfaceIdiom == .phone ? 48 : nil
                )
            }
        }
        .padding(
            .horizontal,
            UIDevice.current.userInterfaceIdiom == .phone ? -48 : 0
        )
        .navigationTitle("Details")
    }
}

struct ClassDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ClassDetailView(
            accentColor: .accentColor,
            title: "Algebra 2",
            level: "Honors",
            teacher: "Unknown Instructor",
            creator: "Notecard++",
            school: "BCHS"
        )
    }
}
