//
//  StudyView.swift
//  NotecardPlusPlus
//
//  Created by Jason Burke on 8/23/22.
//

import SwiftUI

struct StudyView: View {
    var body: some View {
        VStack {
            Text("Question")
            Text("AnswerBox")
            HStack {
                Button {
                    
                } label: {
                    Text("True")
                        .frame(maxWidth: .infinity)
                        .padding()
                }
                Button {
                    
                } label: {
                    Text("False")
                        .frame(maxWidth: .infinity)
                        .padding()
                }
            }
            .frame(maxWidth: 200)
            .buttonStyle(.borderedProminent)
        }
    }
}

//struct StudyView: View {
//    @Environment(\.managedObjectContext) private var viewContext
//
//    @FetchRequest(
//        entity: Question.entity(),
//        sortDescriptors: [],
//        animation: .default
//    )
//    private var questions: FetchedResults<Question>
//
//    @State private var answer: String = ""
//
//    @State private var matchesAnswer: Bool?
//
//    private var currentQuestion: Question {
//        questions.first!
//    }
//
//    var possibleAnswers: [String]
//    var correctAnswer: String
//
//    let accentColor: Color
//
//    var body: some View {
//        Group {
//            Text(
//                currentQuestion.uuid?.uuidString ?? "No UUID Provided"
//            )
//            Text(
//                currentQuestion.type ?? "No Type Provided"
//            )
//            Text(
//                currentQuestion.question ?? "No Questions Provided"
//            )
//            Text(
//                currentQuestion.answer ?? "No Answers Provided"
//            )
//        }
//        if (currentQuestion.type == "MULTICHOICE") {
//            Group {
//                ForEach(possibleAnswers, id: \.self) { thisAnswer in
//                    Button {
//                        answer = thisAnswer
//                        if (answer.lowercased() == correctAnswer.lowercased()) {
//                            matchesAnswer = true
//                        } else {
//                            matchesAnswer = false
//                        }
//                    } label: {
//                        Text("\(thisAnswer)")
//                            .padding()
//                    }
//                    .buttonStyle(.borderedProminent)
//                    .tint(matchesAnswer == nil ?
//                          accentColor.opacity(0.5) :
//                            thisAnswer.lowercased() == correctAnswer.lowercased() ?
//                          Color.green :
//                            Color.red)
//                }
//            }
//        }
//        if (currentQuestion.type == "SHORTANSWER") {
//            Group {
//                TextField(
//                    "Answer",
//                    text: $answer,
//                    prompt: Text("Answer")
//                )
//                .textFieldStyle(.roundedBorder)
//
//                Button {
//                    if (answer.lowercased() == correctAnswer.lowercased()) {
//                        matchesAnswer = true
//                    } else {
//                        matchesAnswer = false
//                    }
//                } label: {
//                    Text("Submit")
//                        .padding()
//                }
//                .buttonStyle(.borderedProminent)
//                .tint(matchesAnswer == nil ?
//                      accentColor.opacity(0.5) :
//                        matchesAnswer == true ?
//                      Color.green :
//                        Color.red)
//            }
//        }
//    }
//}

struct StudyView_Previews: PreviewProvider {
    static var previews: some View {
        StudyView()
            .environment(
                \.managedObjectContext,
                 PersistenceController.preview.container.viewContext
            )
    }
}
