//
//  Friend.swift
//  FriendsFavoriteMovies
//
//  Created by Schubert Anselme on 2026-01-07.
//

import Foundation
import SwiftData

@Model
class Friend {
  var name: String
  var favoriteMovie: Movie?

  init(name: String) {
    self.name = name
  }
}

extension Friend {
  @MainActor static let sampleData = [
    Friend(name: "Elena"),
    Friend(name: "Graham"),
    Friend(name: "Mayuri"),
    Friend(name: "Rich"),
    Friend(name: "Rody"),
  ]
}
