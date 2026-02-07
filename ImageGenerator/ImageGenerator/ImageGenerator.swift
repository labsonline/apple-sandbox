//
//  ImageGenerator.swift
//  ImageGenerator
//
//  Created by Schubert Anselme on 2026-02-06.
//

import Foundation
import ImagePlayground

@Observable
class ImageGenerator {
  var recipe = ImageGenerator.defaultRecipe
  var style: ImagePlaygroundStyle?
  var ingredients: [String] = []

  var concepts: [ImagePlaygroundConcept] {
    var playgroundConcepts = [ImagePlaygroundConcept.text(recipe)]
    for ingredient in ingredients {
      playgroundConcepts.append(.text(ingredient))
    }
    return playgroundConcepts
  }

  func generate() async -> Result<ImageCreator.CreatedImage, ImageCreator.Error> {
    guard let style else { return .failure(ImageCreator.Error.creationFailed) }

    do {
      let imageCreator = try await ImageCreator()
      let images = imageCreator.images(for: concepts, style: style, limit: 1)

      for try await image in images {
        return .success(image)
      }
    } catch {
      return .failure(error as! ImageCreator.Error)
    }

    return .failure(ImageCreator.Error.creationFailed)
  }

  func resetGenerator() {
    recipe = ImageGenerator.defaultRecipe
    style = nil
    ingredients.removeAll()
  }
}

extension ImageGenerator {
  static let recipes = ["Salad", "Sandwich", "Ice Cream"]
  static let styles: [ImagePlaygroundStyle] = [
    .animation,
    .illustration,
    .sketch
  ]

  static let imageSize: CGFloat = 256
  private static let defaultRecipe = recipes[0]
}
