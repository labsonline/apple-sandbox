//
//  QuestionView.swift
//  GenerableQuiz
//
//  Created by Schubert Anselme on 2026-02-07.
//

import SwiftUI
import FoundationModels

struct QuestionView: View {
  @Environment(QuizGenerator.self) private var generator
  @State var selectedAnswer: Answer.PartiallyGenerated?
  @State private var showConfirmation = false
  var question: Question.PartiallyGenerated

  var body: some View {
    VStack(alignment: .leading) {
      if let text = question.text {
        HStack {
          Text(text)
          Spacer()
          Button { showConfirmation = true } label: {
            Image(systemName: "arrow.counterclockwise")
          }
          .confirmationDialog("Regenerate Question", isPresented: $showConfirmation) {
            Button("Regenrate", role: .destructive) {
              generator.regenerate(question: question)
            }
          } message: { Text("Replace this question with a new one?") }
        }
        .padding(.bottom, 8)
      }

      if let answers = question.answers {
        ForEach(answers) { answer in
          AnswerView(displayedAnswer: answer, selectedAnswer: $selectedAnswer)
        }
      }

      if let selectedAnswer = selectedAnswer {
        Text(selectedAnswer.explanation ?? "Generating...")
          .font(.body.italic())
          .padding(.top, 8)
          .foregroundStyle(.secondary)
      }
    }
    .padding(24)
    .background(.background, in: RoundedRectangle(cornerRadius: 24))
  }
}

#Preview {
  QuestionView(question: Question.sample.asPartiallyGenerated())
    .environment(QuizGenerator(topic: "Marine Life"))
}
