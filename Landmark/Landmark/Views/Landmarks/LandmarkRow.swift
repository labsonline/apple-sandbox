//
//  LandmarkRow.swift
//  Landmark
//
//  Created by Schubert Anselme on 2025-06-17.
//

import SwiftUI

struct LandmarkRow: View {
  var landmark: Landmark

  var body: some View {
    HStack {
      landmark.image
        .resizable()
        .frame(width: 50, height: 50)
        .cornerRadius(5)
      VStack(alignment: .leading) {
        Text(landmark.name)
          .bold()
        #if !os(watchOS)
        Text(landmark.park)
          .font(.caption)
          .foregroundStyle(.secondary)
        #endif
      }

      Spacer()

      if landmark.isFavorite {
        Image(systemName: "star.fill")
          .foregroundStyle(.yellow)
      }
    }
    .padding()
  }
}

#Preview {
  let landmarks = ModelData().landmarks
  return Group {
    LandmarkRow(landmark: landmarks[0])
    LandmarkRow(landmark: landmarks[1])
  }
}
