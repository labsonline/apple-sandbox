//
//  ContentView.swift
//  ImageGenerator
//
//  Created by Schubert Anselme on 2026-02-06.
//

import SwiftUI

struct ContentView: View {
  @Environment(AppManager.self) private var appManager

  var body: some View {
    VStack {
      if appManager.showKitchen {
        KitchenView()
      } else {
        StartView()
      }
    }
    .frame(minWidth: ImageGenerator.imageSize, maxWidth: 400, minHeight: 550)
    .overlay {
      if appManager.isGenerating { loadingView() }
    }
  }
}

private extension ContentView {
  func loadingView() -> some View {
    HStack(spacing: 8) {
      ProgressView()
      Text("Generating Image...")
    }
    .padding()
    .background(.ultraThinMaterial)
  }
}

#Preview {
  ContentView()
    .previewEnvironment(generateImage: true)
}
