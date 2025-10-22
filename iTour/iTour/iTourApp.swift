//
//  iTourApp.swift
//  iTour
//
//  Created by Schubert Anselme on 2025-07-21.
//

import SwiftUI
import SwiftData

@main
struct iTourApp: App {
  var body: some Scene {
    WindowGroup {
      ContentView()
    }
    .modelContainer(for: Destination.self)
  }
}
