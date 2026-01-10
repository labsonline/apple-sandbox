//
//  GratefulMomentsApp.swift
//  GratefulMoments
//
//  Created by Schubert Anselme on 2026-01-08.
//

import SwiftUI
import SwiftData

@main
struct GratefulMomentsApp: App {
  let dataContainer = DataContainer()

  var body: some Scene {
    WindowGroup {
      ContentView()
        .environment(dataContainer)
    }
    .modelContainer(dataContainer.modelContainer)
  }
}
