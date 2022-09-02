import SwiftUI

struct StudyView: View {
    var questionList: [Question]?
    
    @State var question: String
    @State var type: String
    
    @State var correctAnswers: Int
    @State var listedAnswers: [String]
    @State var listedCorrectAnswers: [String]
    
    @State var questionIndex: Int?
    
    @State var showCorrectAnswers: Bool = false
    
    var accentColor: Color
    
    init(questionList: [Question], accentColor: Color = .accentColor) {
        self.questionList = questionList
        self.question = questionList.first?.question ?? "Error: QuestionList empty"
        self.type = questionList.first?.type ?? "Error: QuestionList empty"
        self.correctAnswers = Int(questionList.first?.correctAnswers ?? 1)
        self.listedAnswers = questionList.first?.answer?.components(separatedBy: ",").shuffled() ?? [""]
        self.listedCorrectAnswers = Array(questionList.first?.answer?.components(separatedBy: ",")[0...Int((questionList.first?.correctAnswers ?? 1) - 1)] ?? [""])
        self.questionIndex = 0
        self.accentColor = accentColor
    }
    
    init(
        question: String,
        type: String,
        answers: String,
        correctAnswers: Int = 1,
        accentColor: Color = .accentColor
    ) {
        self.question = question
        self.type = type
        self.correctAnswers = correctAnswers
        self.listedAnswers = answers.components(separatedBy: ",").shuffled()
        self.listedCorrectAnswers = Array(answers.components(separatedBy: ",")[0...correctAnswers - 1])
        self.questionIndex = nil
        self.accentColor = accentColor
    }
    
    init() {
        self.question = "This is a test question."
        self.type = "MULTICHOICE"
        self.correctAnswers = 1
        self.listedAnswers = "answer1,answer2,answer3,answer4,answer5,answer6"
            .components(separatedBy: ",")
            .shuffled()
        self.listedCorrectAnswers = Array(
            "answer1,answer2,answer3,answer4,answer5,answer6"
                .components(separatedBy: ",")[0...0]
        )
        self.questionIndex = nil
        self.accentColor = .accentColor
    }
    
    var body: some View {
        VStack {
            Text("\(question)")
            Text("There \(correctAnswers == 1 ? "is" : "are") \(correctAnswers) correct \(correctAnswers == 1 ? "answer" : "answers").")
            LazyVGrid(columns: [.init(.adaptive(minimum: 150))]) {
                ForEach(
                    listedAnswers,
                    id: \.self
                ) { possibleAnswer in
                    Button {
                        showCorrectAnswers = true
                    } label: {
                        Text("\(possibleAnswer)")
                            .frame(maxWidth: .infinity)
                            .padding()
                    }
                    .tint(
                        showCorrectAnswers == true ?
                            (listedCorrectAnswers
                                .firstIndex(of: possibleAnswer) == nil ?
                                .red :
                                .green
                            ) : accentColor
                    )
                }
            }
            .padding()
            .ifCondition(showCorrectAnswers == true) { button in
                button.buttonStyle(.borderedProminent)
            } else: { button in
                button.buttonStyle(.bordered)
            }
        }
    }
}

struct StudyView_Previews: PreviewProvider {
    static var previews: some View {
        StudyView()
            .environment(
                \.managedObjectContext,
                PersistenceController.preview.container.viewContext
            )
    }
}
