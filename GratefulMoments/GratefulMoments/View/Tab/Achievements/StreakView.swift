//
//  StreakView.swift
//  GratefulMoments
//
//  Created by Schubert Anselme on 2026-01-09.
//

import SwiftUI

struct StreakView: View {
  var numberOfDays: Int

  var attributedText: AttributedString {
    var attributedString = AttributedString(localized: "^[\(numberOfDays) \nDays](inflect: true)")
    if let range = attributedString.range(of: "\(numberOfDays)") {
      attributedString[range].font = .system(size: 70)
    }
    return attributedString
  }

  var body: some View {
    Hexagon(borderColor: .secondary) {
      VStack(spacing: 8) {
        Text("Streak \(Image(systemName: "flame.fill"))")
          .foregroundStyle(.ember)
        Text(attributedText)
          .multilineTextAlignment(.center)
      }
    }
  }
}

#Preview {
  StreakView(numberOfDays: 0)
  StreakView(numberOfDays: 1)
  StreakView(numberOfDays: 23)
}
