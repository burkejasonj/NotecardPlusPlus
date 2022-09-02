import SwiftUI

struct ClassRowView: View {
    var classInfo: Class?

    var accentColor: Color
    var title: String
    var level: String
    
    var teacher: String
    var creator: String
    
    let scale: CGFloat = 1
    
    var gradient: Gradient
    
    init() {
        self.accentColor = Color("248ace")
        self.title = "Unknown Class"
        self.level = ""
        
        self.teacher = "Unknown Instructor"
        self.creator = "Unknown Provider"
        
        self.gradient = Gradient(colors: [accentColor, Color.clear])
    }
    
    init(classInfo: Class?) {
        self.classInfo = classInfo
        
        self.accentColor = Color(hex: (classInfo?.color) ?? "248ace") ?? Color.accentColor
        self.title = classInfo?.name ?? "Unknown Class"
        self.level = classInfo?.level ?? ""
        
        self.teacher = classInfo?.teacher?.name ?? "Unknown Instructor"
        self.creator = classInfo?.creator?.name ?? "Unknown Provider"
        
        self.gradient = Gradient(colors: [accentColor, Color.clear])
    }
    
    init(accentColor: Color?, title: String, level: String) {
        self.classInfo = nil
        
        self.accentColor = accentColor ?? Color.accentColor
        self.title = title
        self.level = level
        
        self.teacher = "Unknown Instructor"
        self.creator = "Unknown Provider"
        
        self.gradient = Gradient(colors: [self.accentColor, Color.clear])
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
