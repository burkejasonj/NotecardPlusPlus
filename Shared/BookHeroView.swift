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

struct StudyView: View {
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
    
    var possibleAnswers: [String]
    var correctAnswer: String
    
    let accentColor: Color
    
    var body: some View {
        Group {
            Text(
                currentQuestion.uuid?.uuidString ?? "No UUID Provided"
            )
            Text(
                currentQuestion.type ?? "No Type Provided"
            )
            Text(
                currentQuestion.question ?? "No Questions Provided"
            )
            Text(
                currentQuestion.answer ?? "No Answers Provided"
            )
        }
        if (currentQuestion.type == "MULTICHOICE") {
            Group {
                ForEach(possibleAnswers, id: \.self) { thisAnswer in
                    Button {
                        answer = thisAnswer
                        if (answer.lowercased() == correctAnswer.lowercased()) {
                            matchesAnswer = true
                        } else {
                            matchesAnswer = false
                        }
                    } label: {
                        Text("\(thisAnswer)")
                            .padding()
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(matchesAnswer == nil ?
                          accentColor.opacity(0.5) :
                        thisAnswer.lowercased() == correctAnswer.lowercased() ?
                        Color.green :
                        Color.red)
                }
            }
        }
        if (currentQuestion.type == "SHORTANSWER") {
            Group {
                TextField(
                    "Answer",
                    text: $answer,
                    prompt: Text("Answer")
                )
                .textFieldStyle(.roundedBorder)
                
                Button {
                    if (answer.lowercased() == correctAnswer.lowercased()) {
                        matchesAnswer = true
                    } else {
                        matchesAnswer = false
                    }
                } label: {
                    Text("Submit")
                        .padding()
                }
                .buttonStyle(.borderedProminent)
                .tint(matchesAnswer == nil ?
                      accentColor.opacity(0.5) :
                        matchesAnswer == true ?
                      Color.green :
                        Color.red)
            }
        }
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

