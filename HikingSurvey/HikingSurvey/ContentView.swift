//
//  ContentView.swift
//  HikingSurvey
//
//  Created by Schubert Anselme on 2026-02-05.
//

import SwiftUI

struct ContentView: View {
  @FocusState private var textFieldIsFocused: Bool
  @State var responses: [Response] = []
  @State private var responseText = ""
  var scorer = Scorer()

  var body: some View {
    VStack {
      Text("Opinions on Hiking")
        .frame(maxWidth: .infinity)
        .font(.title)
        .padding(.top, 24)
      ScrollView {
        ChartView(responses: responses)
        ForEach(responses) { response in
          ResponseView(response: response)
        }
      }
      HStack {
        TextField("What do you think about hiking?", text: $responseText)
          .textFieldStyle(.roundedBorder)
          .lineLimit(5)
        Button("Done") {
          guard !responseText.isEmpty else { return }
          saveResponse(text: responseText)
          responseText = ""
          textFieldIsFocused = false
        }
        .padding(.horizontal, 4)
      }
      .padding(.bottom, 8)
    }
    .onAppear {
      for response in Response.sampleResponses {
        saveResponse(text: response)
      }
    }
    .padding(.horizontal)
    .background(Color(white: 0.94))
  }
}

extension ContentView {
  func saveResponse(text: String) {
    let score = scorer.score(text)
    let response = Response(text: text, score: score)
    responses.insert(response, at: 0)
  }
}

#Preview {
  ContentView()
}
