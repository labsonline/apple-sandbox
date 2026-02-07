//
//  ImageGeneratorApp.swift
//  ImageGenerator
//
//  Created by Schubert Anselme on 2026-02-06.
//

import SwiftUI

@main
struct ImageGeneratorApp: App {
  @State var appManager = AppManager()

  var body: some Scene {
    Window("ImageGenerator", id: "main") {
      ContentView()
        .environment(appManager)
    }
    .commands {
      CommandMenu("Actions") {
        ImageButtonsView(displayForMenu: true)
          .environment(appManager)
      }
    }
  }
}
