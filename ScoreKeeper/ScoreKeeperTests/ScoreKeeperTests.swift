//
//  ScoreKeeperTests.swift
//  ScoreKeeperTests
//
//  Created by Schubert Anselme on 2026-01-06.
//

import Testing
@testable import ScoreKeeper

@MainActor
struct ScoreKeeperTests {

  @Test("Reset player scores", arguments: [0, 10, 20])
  func resetScores(to newValue: Int) async throws {
    var scoreboard = Scoreboard(players: [
      Player(name: "Elisha", score: 0),
      Player(name: "Andre", score: 5),
    ])
    scoreboard.resetScores(to: newValue)

    for player in scoreboard.players {
      #expect(player.score == newValue)
    }
  }

  @Test("Highest score wins")
  func highestScoreWins() async throws {
    let scoreboard = Scoreboard(
      players: [
        Player(name: "Elisha", score: 0),
        Player(name: "Andre", score: 4),
      ],
      state: .gameOver,
      doesHighestScoreWins: true,
    )

    let winners = scoreboard.winners

    #expect(winners == [Player(name: "Andre", score: 4)])
  }

  @Test("Lowest scores wins")
  func lowestScoreWins() async throws {
    let scoreboard = Scoreboard(
      players: [
        Player(name: "Elisha", score: 0),
        Player(name: "Andre", score: 4),
      ],
      state: .gameOver,
      doesHighestScoreWins: false,
    )

    let winners = scoreboard.winners

    #expect(winners == [Player(name: "Elisha", score: 0)])
  }

}
