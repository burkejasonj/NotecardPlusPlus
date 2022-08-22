import SwiftUI

struct ClassRowView: View {
    var classInfo: Class?
    
    var accentColor: Color {
        Color(hex: (classInfo?.color) ?? "248ace") ?? Color.accentColor
    }
    
    var title: String {
        classInfo?.name ?? "Unknown Class"
    }
    var level: String {
        classInfo?.level ?? ""
    }
    var teacher: String {
        classInfo?.teacher?.name ?? "Unknown Instructor"
    }
    var creator: String {
        classInfo?.creator?.name ?? "Unknown Provider"
    }
    
    let scale: CGFloat = 1
    
    var gradient: Gradient {
        Gradient(colors: [accentColor, Color.clear])
    }
    
    var body: some View {
        HStack {
            BookCoverView(
                accentColor: accentColor,
                scale: scale,
                gradient: gradient
            )
            VStack(alignment: .leading) {
                Group {
                    Text(title)
                        .fontWeight(Font.Weight.semibold)
                        .lineLimit(2)
                    Text(level)
                }
                .foregroundColor(Color(UIColor.label))
                Group {
                    Text(teacher)
                    Text("Provided by \(creator)")
                }
                .foregroundColor(Color(UIColor.secondaryLabel))
            }
            .lineLimit(1)
        }
    }
}

struct ClassRowView_Previews: PreviewProvider {
    static var previews: some View {
        ClassRowView()
    }
}
