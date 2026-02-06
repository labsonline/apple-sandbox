//
//  TrailInfo.swift
//  TrailAnalyzer
//
//  Created by Schubert Anselme on 2026-02-06.
//

import Foundation

struct TrailInfo {
  static let lowDanger = 0
  static let highDanger = 1

  static var empty = TrailInfo()
  static var sample = TrailInfo(
    distance: 20,
    elevation: 200,
    terrain: .dirt,
    wildlifeDangerLevel: highDanger
  )

  var distance: Int?
  var elevation: Int?
  var terrain: Terrain?
  var wildlifeDangerLevel: Int = lowDanger
}
