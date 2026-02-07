//
//  ImageButtonsView.swift
//  ImageGenerator
//
//  Created by Schubert Anselme on 2026-02-06.
//

import SwiftUI

struct ImageButtonsView: View {
  @Environment(AppManager.self) private var appManager
  var displayForMenu = false

  var body: some View {
    if displayForMenu {
      Group {
        regenerateButton
        imagePlaygroundButton
        shareButton
      }
    } else {
      regenerateButton
        .toolbar {
          ToolbarItem { imagePlaygroundButton }
          ToolbarItem(placement: .primaryAction) { shareButton }
        }
    }
  }
}

private extension ImageButtonsView {
  @ViewBuilder var shareButton: some View {
    if let image = appManager.currentImage {
      let preview = SharePreview("My Recipe", image: image)
      ShareLink(item: image, preview: preview) {
        Label("Share", systemImage: "square.and.arrow.up")
      }
      .buttonStyle(.borderedProminent)
    }
  }

  var regenerateButton: some View {
    Button("Regenerate", systemImage: "arrow.clockwise") {
      appManager.generateImage()
    }
    .buttonStyle(.plain)
    .font(.footnote)
    .keyboardShortcut("r", modifiers: .command)
    .disabled(!appManager.showKitchen)
  }

  var imagePlaygroundButton: some View {
    Button("Edit in Image Playground", systemImage: "apple.image.playground") {
      appManager.showPlayground = true
    }
    .keyboardShortcut("i", modifiers: [.command, .shift])
    .disabled(appManager.currentImage == nil)
  }
}

#Preview {
  ImageButtonsView(displayForMenu: true)
    .previewEnvironment(generateImage: false)
}
