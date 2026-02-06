//
//  TextRecognitionView.swift
//  SignDecoder
//
//  Created by Schubert Anselme on 2026-02-06.
//

import SwiftUI
import Vision

struct TextRecognitionView: View {
  @State private var textRecognizer: TextRecognizer?
  let imageResource: ImageResource
  let boundingColor = Color(red: 1.00, green: 0.00, blue: 0.85)

  var body: some View {
    VStack {
      Image(imageResource)
        .resizable()
        .aspectRatio(contentMode: .fit)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .task {
          textRecognizer = await TextRecognizer(imageResource: imageResource)
        }
        .overlay {
          if let observations = textRecognizer?.observations {
            ForEach(observations, id: \.uuid) { observation in
              BoundsRect(normalizeRect: observation.boundingBox)
                .stroke(boundingColor, lineWidth: 3)
            }
          }
        }

      Spacer()

      TranslationView(text: textRecognizer?.recognizedText ?? "", isProcessing: isProcessing)
    }
    .padding()
    .trailTheme()
    .navigationTitle("Sign Info")
  }
}

private extension TextRecognitionView {
  var isProcessing: Bool { textRecognizer == nil }
}

#Preview {
  NavigationStack {
    TextRecognitionView(imageResource: .sign1)
      .navigationBarTitleDisplayMode(.inline)
  }
}
