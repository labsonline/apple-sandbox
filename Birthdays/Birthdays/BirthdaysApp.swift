//
//  BirthdaysApp.swift
//  Birthdays
//
//  Created by Schubert Anselme on 2026-01-06.
//

import SwiftUI
import SwiftData

@main
struct BirthdaysApp: App {
  var body: some Scene {
    WindowGroup {
      ContentView()
        .modelContainer(for: Friend.self)
    }
  }
}
