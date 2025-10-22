//
//  Hike.swift
//  Landmark
//
//  Created by Schubert Anselme on 2025-06-18.
//

import Foundation

@MainActor
struct Hike: @MainActor Codable, Hashable, Identifiable {
  var id: Int
  var name: String
  var distance: Double
  var difficulty: Int
  var observations: [Observation]

  static let formatter = LengthFormatter()

  var distanceText: String {
    Hike.formatter
      .string(fromValue: distance, unit: .kilometer)
  }

  struct Observation: @MainActor Codable, Hashable {
    var distanceFromStart: Double
    var elevation: Range<Double>
    var pace: Range<Double>
    var heartRate: Range<Double>
  }
}
