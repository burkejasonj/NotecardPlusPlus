import SwiftUI

struct BookHeroView: View {

    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        entity: Question.entity(),
        sortDescriptors: [],
        animation: .default
    )
    private var questions: FetchedResults<Question>
    
    @State private var answer: String = ""
    
    @State private var matchesAnswer: Bool?
    
    private var currentQuestion: Question {
        questions.first!
    }
    
    private var possibleAnswers: [String] {
        currentQuestion.answer!.components(separatedBy: ",").shuffled()
    }
    
    private var correctAnswer: String {
        currentQuestion.answer!.components(separatedBy: ",").first!
    }
    
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
                    possibleAnswers: possibleAnswers,
                    correctAnswer: correctAnswer,
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

