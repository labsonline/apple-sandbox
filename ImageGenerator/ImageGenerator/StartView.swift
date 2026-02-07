//
//  StartView.swift
//  ImageGenerator
//
//  Created by Schubert Anselme on 2026-02-06.
//

import SwiftUI
import ImagePlayground

struct StartView: View {
  @Environment(AppManager.self) private var appManager

  var body: some View {
    @Bindable var imageGenerator = appManager.imageGenerator

    VStack(alignment: .leading, spacing: 16) {
      Text("Create a Unique Dish")
        .font(.largeTitle.weight(.semibold))
        .frame(maxWidth: .infinity, alignment: .center)

      Label("Choose a Dish", systemImage: "fork.knife")
        .padding(.top, 8)
      Picker("Recipes", selection: $imageGenerator.recipe) {
        ForEach(ImageGenerator.recipes, id: \.description) {
          recipe in Text(recipe)
        }
      }

      Label("Choose an Image Style", systemImage: "paintpalette.fill")
        .padding(.top, 8)
      Picker("Styles", selection: $imageGenerator.style) {
        ForEach(ImageGenerator.styles) { style in
          Text(style.id.capitalized).tag(style)
        }
      }

      Spacer()
    }
    .toolbar {
      ToolbarItem(placement: .primaryAction) {
        Button("Generate Image") {
          appManager.generateImage()
        }
        .buttonStyle(.glassProminent)
        .disabled(imageGenerator.style == nil)
      }
    }
    .pickerStyle(.segmented)
    .labelsHidden()
    .frame(width: ImageGenerator.imageSize)
    .padding()
  }
}

#Preview {
  StartView()
    .previewEnvironment()
}
