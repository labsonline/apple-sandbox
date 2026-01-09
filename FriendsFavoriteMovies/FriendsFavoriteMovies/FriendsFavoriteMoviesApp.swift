//
//  FriendsFavoriteMoviesApp.swift
//  FriendsFavoriteMovies
//
//  Created by Schubert Anselme on 2026-01-07.
//

import SwiftUI
import SwiftData

@main
struct FriendsFavoriteMoviesApp: App {
  var body: some Scene {
    WindowGroup {
      ContentView()
    }
    .modelContainer(for: [Friend.self, Movie.self])
  }
}
