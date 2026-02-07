//
//  Quiz.swift
//  GenerableQuiz
//
//  Created by Schubert Anselme on 2026-02-07.
//

import FoundationModels

@Generable
struct Quiz {
  @Guide(description: "The questions associated with this quiz.", .count(4))
  let questions: [Question]
}
