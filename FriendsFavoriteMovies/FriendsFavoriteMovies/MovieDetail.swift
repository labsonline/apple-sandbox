//
//  MovieDetail.swift
//  FriendsFavoriteMovies
//
//  Created by Schubert Anselme on 2026-01-07.
//

import SwiftUI
import SwiftData

struct MovieDetail: View {
  @Bindable var movie: Movie

  @Environment(\.dismiss) private var dismiss
  @Environment(\.modelContext) private var context

  let isNew: Bool

  var sortedFriends: [Friend] {
    movie.favoritedBy.sorted { first, second in
      first.name < second.name
    }
  }

  var body: some View {
    Form {
      TextField("Movie", text: $movie.title)
      DatePicker("Release Date",
                 selection: $movie.releaseDate,
                 displayedComponents: .date)

      if !movie.favoritedBy.isEmpty {
        Section("Favorited By") {
          ForEach(sortedFriends) { friend in
            Text(friend.name)
          }
        }
      }
    }
    .navigationTitle(isNew ? "New Movie" : "Movie")
#if os(iOS)
    .navigationBarTitleDisplayMode(.inline)
#endif
    .toolbar {
      if isNew {
        ToolbarItem(placement: .confirmationAction) {
          Button("Save") { dismiss() }
        }
        ToolbarItem(placement: .cancellationAction) {
          Button("Cancel") {
            context.delete(movie)
            dismiss()
          }
        }
      }
    }
  }

  init(movie: Movie, isNew: Bool = false) {
    self.movie = movie
    self.isNew = isNew
  }
}

#Preview {
  NavigationStack {
    MovieDetail(movie: SampleData.shared.movie)
  }
}

#Preview("New Movie") {
  NavigationStack {
    MovieDetail(movie: SampleData.shared.movie, isNew: true)
  }
}
