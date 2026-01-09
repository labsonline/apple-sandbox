//
//  ContentView.swift
//  ScoreKeeper
//
//  Created by Schubert Anselme on 2026-01-06.
//

import SwiftUI

struct ContentView: View {
  @State private var scoreboard = Scoreboard()
  @State private var startingPoints = 0

  var body: some View {
    VStack(alignment: .leading) {
      Text("Score Keeper")
        .font(.title)
        .bold()
        .padding(.bottom)

      SettingsView(
        doesHighestScoreWins: $scoreboard.doesHighestScoreWins, startingPoints: $startingPoints
      )
      .disabled(scoreboard.state != .setup)

      Grid {
        GridRow {
          Text("Player")
            .gridColumnAlignment(.leading)
          Text("Score")
            .opacity(scoreboard.state == .setup ? 0 : 1)
        }
        .font(.headline)

        ForEach($scoreboard.players) { $player in
          GridRow {
            HStack {
              if scoreboard.winners.contains(player) {
                Image(systemName: "crown.fill")
                  .foregroundStyle(.yellow)
              }
              TextField("Name", text: $player.name)
                .disabled(scoreboard.state != .setup)
            }
            Text("\(player.score)")
              .opacity(scoreboard.state == .setup ? 0 : 1)
            Stepper("\(player.score)", value: $player.score)
              .labelsHidden()
              .opacity(scoreboard.state == .setup ? 0 : 1)
          }
        }
      }
      .padding(.vertical)

      Button("Add Player", systemImage: "plus") {
        scoreboard.players.append(Player(name: "", score: 0))
      }
      .opacity(scoreboard.state == .setup ? 1 : 0)

      Spacer()

      HStack {
        Spacer()
        switch scoreboard.state {
        case .setup:
          Button("Start Game", systemImage: "play.fill") {
            scoreboard.state = .playing
            scoreboard.resetScores(to: startingPoints)
          }
        case .playing:
          Button("Stop Game", systemImage: "stop.fill") {
            scoreboard.state = .gameOver
          }
        case .gameOver:
          Button("Reset Game", systemImage: "arrow") {
            scoreboard.state = .setup
          }
        }
        Spacer()
      }
      .buttonStyle(.bordered)
      .buttonBorderShape(.capsule)
      .controlSize(.large)
      .tint(.blue)
    }
    .padding()
  }
}

#Preview {
  ContentView()
}
