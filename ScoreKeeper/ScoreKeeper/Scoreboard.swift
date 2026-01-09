//
//  Scoreboard.swift
//  ScoreKeeper
//
//  Created by Schubert Anselme on 2026-01-06.
//

import Foundation

struct Scoreboard {
  var players: [Player] = [
    Player(name: "Elisha", score: 0),
    Player(name: "Andre", score: 0),
    Player(name: "Jasmine", score: 0),
  ]

  var state: GameState = .setup
  var doesHighestScoreWins = true

  var winners: [Player] {
    guard state == .gameOver else { return [] }

    var winningScore = 0
    if doesHighestScoreWins {
      winningScore = Int.min
      for player in players {
        winningScore = max(player.score, winningScore)
      }
    } else {
      winningScore = Int.max
      for player in players {
        winningScore = min(player.score, winningScore)
      }
    }

    return players.filter { player in
      player.score == winningScore
    }
  }

  mutating func resetScores(to newValue: Int) {
    for index in 0..<players.count {
      players[index].score = newValue
    }
  }
}
