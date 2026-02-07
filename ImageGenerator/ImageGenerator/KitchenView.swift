//
//  KitchenView.swift
//  ImageGenerator
//
//  Created by Schubert Anselme on 2026-02-06.
//

import SwiftUI
import ImagePlayground

struct KitchenView: View {
  @Environment(AppManager.self) private var appManager

  var body: some View {
    @Bindable var appManager = appManager

    VStack {
      Text("Refine your Dish")
        .font(.largeTitle.weight(.semibold))
      imageArea
      ImageButtonsView()
      IngredientListView()
      Spacer()
      if let error = appManager.error {
        Text(error.localizedDescription)
          .foregroundStyle(Color.red)
      }
    }
    .padding()
    .imagePlaygroundSheet(
      isPresented: $appManager.showPlayground,
      concepts: appManager.imageGenerator.concepts,
      sourceImage: appManager.currentImage.map(Image.init),
      onCompletion: { url in
        if let data = try? Data(contentsOf: url),
           let nsImage = NSImage(data: data) {
          appManager.currentImage = nsImage
        }
      }
    )
    .toolbar {
      ToolbarItem(placement: .navigation) {
        Button("Start Over", systemImage: "chevron.left") { appManager.reset() }
      }
    }
  }
}

private extension KitchenView {
  var imageArea: some View {
    Group {
      if let image = appManager.currentImage {
        Image(nsImage: image)
          .resizable()
          .aspectRatio(contentMode: .fit)
      } else {
        Rectangle().fill(.gray.opacity(0.2))
      }
    }
    .frame(width: ImageGenerator.imageSize, height: ImageGenerator.imageSize)
    .clipShape(RoundedRectangle(cornerRadius: 16))
  }
}

#Preview {
  KitchenView()
    .previewEnvironment()
}
