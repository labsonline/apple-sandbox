//
//  AppManager.swift
//  ImageGenerator
//
//  Created by Schubert Anselme on 2026-02-06.
//

import SwiftUI
import ImagePlayground

@Observable
class AppManager {
  private(set) var error: Error?
  private(set) var isGenerating = false
  private var task: Task<Void, Never>?

  let imageGenerator = ImageGenerator()
  var showPlayground = false
  var currentImage: NSImage?

  var showKitchen: Bool { currentImage != nil || isGenerating }

  func generateImage() {
    error = nil
    isGenerating = true
    task?.cancel()

    task = Task {
      let result = await imageGenerator.generate()

      switch result {
      case .success(let generatedImage):
        currentImage = NSImage(cgImage: generatedImage.cgImage, size: .zero)
        isGenerating = false
      case .failure(let error):
        do {
          try Task.checkCancellation()
          self.error = error
          isGenerating = false
        } catch {
          // Task cancelled
        }
      }
    }
  }

  func reset() {
    imageGenerator.resetGenerator()
    currentImage = nil
    error = nil
    isGenerating = false
    task?.cancel()
  }

  func add(ingredient: String) {
    imageGenerator.ingredients.append(ingredient)
    generateImage()
  }

  func remove(ingredient: String) {
    if let index = imageGenerator.ingredients.firstIndex(of: ingredient) {
      imageGenerator.ingredients.remove(at: index)
    }
    generateImage()
  }
}

extension View {
  func previewEnvironment(generateImage: Bool = true) -> some View {
    let appManager = AppManager()
    appManager.imageGenerator.ingredients.append("Strawberry")
    return environment(appManager)
      .onAppear {
        if generateImage {
          appManager.imageGenerator.style = .animation
          appManager.generateImage()
        }
      }
  }
}
