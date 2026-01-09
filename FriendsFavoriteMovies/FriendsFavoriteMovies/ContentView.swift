//
//  ContentView.swift
//  FriendsFavoriteMovies
//
//  Created by Schubert Anselme on 2026-01-07.
//

import SwiftUI
import SwiftData

struct ContentView: View {
  var body: some View {
    TabView {
      Tab("Friends", systemImage: "person.and.person") {
        FriendList()
      }

      Tab("Movies", systemImage: "film.stack") {
        FilteredMovieList()
      }
    }
  }
}

#Preview {
  ContentView()
    .modelContainer(SampleData.shared.modelContainer)
}
