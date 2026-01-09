//
//  FilteredMovieList.swift
//  FriendsFavoriteMovies
//
//  Created by Schubert Anselme on 2026-01-07.
//

import SwiftUI
import SwiftData

struct FilteredMovieList: View {
  @State private var searchText = ""

  var body: some View {
    NavigationSplitView {
      MovieList(titleFilter: searchText)
        .searchable(text: $searchText)
    } detail: {
      Text("Select a Movie")
        .navigationTitle("Movie")
#if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
#endif
    }
  }
}

#Preview {
  FilteredMovieList()
    .modelContainer(SampleData.shared.modelContainer)
}
