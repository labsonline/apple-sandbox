//
//  Terrain.swift
//  TrailAnalyzer
//
//  Created by Schubert Anselme on 2026-02-06.
//

import Foundation

enum Terrain: String, Identifiable, CaseIterable {
  case paved
  case dirt
  case rocky
  case sandy

  var id: String { rawValue }
}
