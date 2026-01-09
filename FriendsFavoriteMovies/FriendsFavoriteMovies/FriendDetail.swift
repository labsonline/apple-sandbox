//
//  FriendDetail.swift
//  FriendsFavoriteMovies
//
//  Created by Schubert Anselme on 2026-01-07.
//

import SwiftUI
import SwiftData

struct FriendDetail: View {
  @Bindable var friend: Friend

  @Environment(\.dismiss) private var dismiss
  @Environment(\.modelContext) private var context

  @Query(sort: \Movie.title) private var movies: [Movie]

  let isNew: Bool

  var body: some View {
    Form {
      TextField("Name", text: $friend.name)
        .autocorrectionDisabled()
      Picker("Favorite Movie", selection: $friend.favoriteMovie) {
        Text("None").tag(nil as Movie?)
        ForEach(movies) { movie in
          Text(movie.title).tag(movie)
        }
      }
    }
    .navigationTitle(isNew ? "New Friend" : "Friend")
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
            context.delete(friend)
            dismiss()
          }
        }
      }
    }
  }

  init(friend: Friend, isNew: Bool = false) {
    self.friend = friend
    self.isNew = isNew
  }
}

#Preview {
  NavigationStack {
    FriendDetail(friend: SampleData.shared.friend)
  }
  .modelContainer(SampleData.shared.modelContainer)
}

#Preview("New Friend") {
  NavigationStack {
    FriendDetail(friend: SampleData.shared.friend, isNew: true)
  }
  .modelContainer(SampleData.shared.modelContainer)
}
