//
//  TranslationView.swift
//  SignDecoder
//
//  Created by Schubert Anselme on 2026-02-06.
//

import SwiftUI
import Translation

struct TranslationView: View {
  @State private var showingTranslation = false
  var text: String
  var isProcessing: Bool

  var body: some View {
    VStack {
      Text("Identified Text")
        .font(.subheadline.bold())
        .textCase(.uppercase)
        .foregroundStyle(.gray)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.leading)

      Text(text)
        .frame(maxWidth: .infinity, maxHeight: 50, alignment: .topLeading)
        .padding()
        .background(Color(white: 0.9))
        .overlay {
          if isProcessing { ProgressView() }
        }
        .translationPresentation(isPresented: $showingTranslation, text: text)

      Button {
        showingTranslation = true
      } label: {
        Text("Translate")
          .frame(height: 50)
          .frame(maxWidth: .infinity)
          .font(.title2.bold())
          .foregroundColor(.white)
          .background(RoundedRectangle(cornerRadius: 8))
      }
      .disabled(text.isEmpty)
      .padding(.top)
    }
  }
}

#Preview {
  TranslationView(text: "Caution, falling rocks", isProcessing: false)
}

#Preview {
  TranslationView(text: "", isProcessing: true)
}
