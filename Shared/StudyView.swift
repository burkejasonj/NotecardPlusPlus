import SwiftUI

struct StudyView: View {
    @State var question: String
    @State var type: String
    @State var answer: String
    
    @State var correctAnswers: Int
    
    init(
        question: String,
        type: String,
        answer: String,
        correctAnswers: Int
    ) {
        self.question = question
        self.type = type
        self.answer = answer
        self.correctAnswers = correctAnswers
    }
    
    init(
        question: String,
        type: String,
        answer: String
    ) {
        self.question = question
        self.type = type
        self.answer = answer
        self.correctAnswers = 1
    }
    
    init() {
        self.question = "This is a test question."
        self.type = "MULTICHOICE"
        self.answer = "answer1,answer2,answer3,answer4,answer5,answer6"
        self.correctAnswers = 1
    }
    
    var body: some View {
        VStack {
            Text("\(question)")
            Text("There \(correctAnswers == 1 ? "is" : "are") \(correctAnswers) correct \(correctAnswers == 1 ? "answer" : "answers").")
            LazyVGrid(columns: [.init(.adaptive(minimum: 150))]) {
                ForEach(
                    answer.components(separatedBy: ","),
                    id: \.self
                ) { possibleAnswer in
                    Button {
                        
                    } label: {
                        Text("\(possibleAnswer)")
                            .frame(maxWidth: .infinity)
                            .padding()
                    }
                }
            }
            .padding()
            .buttonStyle(.bordered)
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
