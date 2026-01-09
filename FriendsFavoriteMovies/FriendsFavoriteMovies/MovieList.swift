//
//  MovieList.swift
//  FriendsFavoriteMovies
//
//  Created by Schubert Anselme on 2026-01-07.
//

import SwiftUI
import SwiftData

struct MovieList: View {
  @Query private var movies: [Movie]
  @Environment(\.modelContext) private var context
  @State private var newMovie: Movie?

  var body: some View {
    Group {
      if !movies.isEmpty {
        List {
          ForEach(movies) { movie in
            NavigationLink(movie.title) {
              MovieDetail(movie: movie)
            }
          }
          .onDelete(perform: deletMovies(indexes:))
        }
      } else {
        ContentUnavailableView("Add Movies", systemImage: "film.stack")
      }
    }
    .navigationTitle("Movies")
    .toolbar {
      ToolbarItem {
        Button("New Movie", systemImage: "plus", action: addMovie)
      }
#if os(iOS)
      ToolbarItem(placement: .topBarTrailing) {
        EditButton()
      }
#endif
    }
    .sheet(item: $newMovie) { movie in
      NavigationStack {
        MovieDetail(movie: movie, isNew: true)
      }
      .interactiveDismissDisabled()
    }
  }

  init(titleFilter: String = "") {
    let predicate = #Predicate<Movie> { movie in
      titleFilter.isEmpty || movie.title.localizedStandardContains(titleFilter)
    }
    _movies = Query(filter: predicate, sort: \Movie.title)
  }
}

private extension MovieList {
  func addMovie() {
    let newMovie = Movie(title: "", releaseDate: .now)
    context.insert(newMovie)
    self.newMovie = newMovie
  }

  func deletMovies(indexes: IndexSet) {
    for index in indexes {
      context.delete(movies[index])
    }
  }
}

#Preview {
  NavigationStack {
    MovieList()
      .modelContainer(SampleData.shared.modelContainer)
  }
}

#Preview("Filtered") {
  NavigationStack {
    MovieList(titleFilter: "tr")
      .modelContainer(SampleData.shared.modelContainer)
  }
}

#Preview("Empty List") {
  NavigationStack {
    MovieList()
      .modelContainer(for: Movie.self, inMemory: true)
  }
}
