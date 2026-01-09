//
//  SettingsView.swift
//  ScoreKeeper
//
//  Created by Schubert Anselme on 2026-01-06.
//

import SwiftUI

struct SettingsView: View {
  @Binding var doesHighestScoreWins: Bool
  @Binding var startingPoints: Int

  var body: some View {
    VStack(alignment: .leading) {
      Text("Game Rules")
        .font(.headline)
      Divider()
      Picker("Win Condition", selection: $doesHighestScoreWins) {
        Text("Highest Score Wins").tag(true)
        Text("Lowest Score Wins").tag(false)
      }
      Picker("Starting Points", selection: $startingPoints) {
        Text("0 starting points").tag(0)
        Text("10 starting points").tag(10)
        Text("20 starting points").tag(20)
      }
    }
    .padding()
    .background(.thinMaterial, in: .rect(cornerRadius: 10))
  }
}

#Preview {
  @Previewable @State var doesHighestScoreWins = true
  @Previewable @State var startingPoints = 10
  SettingsView(doesHighestScoreWins: $doesHighestScoreWins, startingPoints: $startingPoints)
}
