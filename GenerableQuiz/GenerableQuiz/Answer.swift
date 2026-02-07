//
//  Answer.swift
//  GenerableQuiz
//
//  Created by Schubert Anselme on 2026-02-07.
//

import Foundation
import FoundationModels

@Generable
struct Answer: Identifiable {
  let id = UUID()

  @Guide(description: "The displayed text of the answer.")
  let text: String

  @Guide(description: "Whether this is the correct answer or not.")
  let isCorrect: Bool

  @Guide(description: "Why is this answer correct or incorrect.")
  let explanation: String
}

extension Answer {
  static let correctAnswer = Answer(
    text: "This answer is correct",
    isCorrect: true,
    explanation: "Explanation that this is right."
  )

  static let incorrectAnswer = Answer(
    text: "This answer is incorrect",
    isCorrect: false,
    explanation: "Explanation that this is wrong."
  )
}
