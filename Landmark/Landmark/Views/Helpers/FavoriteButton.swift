//
//  FavoriteButton.swift
//  Landmark
//
//  Created by Schubert Anselme on 2025-06-18.
//

import SwiftUI

struct FavoriteButton: View {
  @Binding var isSet: Bool

  var body: some View {
    Button {
      isSet.toggle()
    } label: {
      Label("Toggle Favorites", systemImage: isSet ? "star.fill" : "star")
        .labelStyle(.iconOnly)
        .foregroundStyle(isSet ? .yellow : .gray)
    }
  }
}

#Preview {
  FavoriteButton(isSet: .constant(true))
}
