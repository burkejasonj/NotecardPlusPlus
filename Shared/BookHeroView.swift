import SwiftUI

struct BookHeroView: View {

    @Environment(\.managedObjectContext) private var viewContext
    
    let accentColor: Color
    let size: CGFloat
    let gradient: Gradient

    var body: some View {
        VStack {
            BookCoverView(
                accentColor: accentColor,
                scale: size / 100,
                gradient: gradient
            )
            NavigationLink() {
                StudyView(
                    question: "This is a test question.",
                    type: "MULTICHOICE",
                    answers: "answer1,answer2,answer3,answer4,answer5,answer6",
                    correctAnswers: 1,
                    accentColor: accentColor
                )
            } label: {
                Text("Study")
                    .padding()
                    .frame(width: size * 0.75)
                    .foregroundColor(Color.init(UIColor.white))
                    .background(accentColor)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
        }
        .frame(width: size * 0.75)
    }
}

struct BookHeroView_Previews: PreviewProvider {
    static var previews: some View {
        BookHeroView(
            accentColor: Color.blue,
            size: 500,
            gradient: .init(colors: [Color.blue, Color.clear])
        )
        .environment(
            \.managedObjectContext,
             PersistenceController.preview.container.viewContext
        )
    }
}

