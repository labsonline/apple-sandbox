//
//  AnswerView.swift
//  GenerableQuiz
//
//  Created by Schubert Anselme on 2026-02-07.
//

import SwiftUI
import FoundationModels

struct AnswerView: View {
  var displayedAnswer: Answer.PartiallyGenerated
  @Binding var selectedAnswer: Answer.PartiallyGenerated?

  var body: some View {
    Button {
      selectedAnswer = displayedAnswer
    } label: {
      HStack {
        Image(systemName: imageName)
        Text(displayedAnswer.text ?? "Generating...")
          .multilineTextAlignment(.leading)
          .foregroundStyle(.primary)
        Spacer()
      }
    }
    .buttonStyle(.bordered)
    .foregroundStyle(tintColor)
    .tint(tintColor)
  }
}

private extension AnswerView {
  var tintColor: Color {
    if let isAnswerCorrect {
      return isAnswerCorrect ? .green : .red
    } else {
      return .secondary
    }
  }

  var imageName: String {
    if let isAnswerCorrect {
      return isAnswerCorrect ? "checkmark.circle.fill" : "xmark.circle.fill"
    } else {
      return "circle"
    }
  }

  var isAnswerCorrect: Bool? {
    guard selectedAnswer?.id == displayedAnswer.id else { return nil }
    return displayedAnswer.isCorrect
  }
}

#Preview {
  @Previewable @State var correctAnswer = Optional(Answer.correctAnswer.asPartiallyGenerated())
  @Previewable @State var incorrectAnswer = Optional(Answer.incorrectAnswer.asPartiallyGenerated())

  VStack {
    AnswerView(displayedAnswer: correctAnswer!, selectedAnswer: $incorrectAnswer)
    AnswerView(displayedAnswer: correctAnswer!, selectedAnswer: $correctAnswer)
    AnswerView(displayedAnswer: incorrectAnswer!, selectedAnswer: $incorrectAnswer)
  }
}
