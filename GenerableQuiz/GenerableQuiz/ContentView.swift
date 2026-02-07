//
//  ContentView.swift
//  GenerableQuiz
//
//  Created by Schubert Anselme on 2026-02-07.
//

import SwiftUI
import FoundationModels

struct ContentView: View {
  var body: some View {
    NavigationStack {
      ZStack {
        Color.gray.opacity(0.1)
          .edgesIgnoringSafeArea(.all)
        
        switch SystemLanguageModel.default.availability {
        case .available: topicSelectionView
        case .unavailable(let unavailableReason):
          UnavailableView(reason: unavailableReason)
        }
      }
    }
  }
}

private extension ContentView {
  var topicSelectionView: some View {
    VStack(spacing: 16) {
      Text("Pick a topic for your quiz")
        .font(.title)

      ForEach(Topic.topics) { topic in
        NavigationLink {
          QuizView()
            .environment(QuizGenerator(topic: topic.name))
        } label: {
          HStack {
            Image(systemName: topic.imageName)
            Text(topic.name)
            Spacer()
            Image(systemName: "arrow.right")
          }
        }
        .buttonStyle(.borderedProminent)
      }

      Spacer()
    }
    .padding()
  }
}

#Preview {
  ContentView()
}
