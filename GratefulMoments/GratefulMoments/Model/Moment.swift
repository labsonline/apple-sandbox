//
//  Moment.swift
//  GratefulMoments
//
//  Created by Schubert Anselme on 2026-01-08.
//

import Foundation
import SwiftData
#if canImport(UIKit)
import UIKit
#endif

@Model
class Moment {
  var title: String
  var note: String
  var imageData: Data?
  var timestamp: Date

  var badges: [Badge]

#if canImport(UIKit)
  var image: UIImage? {
    imageData.flatMap { UIImage(data: $0) }
  }
#endif

  init(title: String, note: String, imageData: Data? = nil, timestamp: Date = .now) {
    self.title = title
    self.note = note
    self.imageData = imageData
    self.timestamp = timestamp
    self.badges = []
  }
}

@MainActor
extension Moment {
  static let sample = sampleData[0]
  static let longTextSample = sampleData[1]
  static let imageSample = sampleData[4]

  static let sampleData = [
    Moment(
      title: "🍅🥳",
      note: "Picked my first homegrown tomato!",
    ),
    Moment(
      title: "Passed the test!",
      note: "The chem exam was tough, but I think I did well 🙌 I'm so glad I reached out to Guillermo and Lee for a study session. It really helped!",
      imageData: {
        #if canImport(UIKit)
        UIImage(named: "Study")?.pngData()
        #else
        nil
        #endif
      }(),
    ),
    Moment(
      title: "Down time",
      note: "So grateful for relaxing evening after a busy week.",
      imageData: {
        #if canImport(UIKit)
        UIImage(named: "Relax")?.pngData()
        #else
        nil
        #endif
      }(),
    ),
    Moment(
      title: "Family ❤️",
      note: ""
    ),
    Moment(
      title: "Rock On!",
      note: "Went to a great concert with Blair 🎶",
      imageData: {
        #if canImport(UIKit)
        UIImage(named: "Concert")?.pngData()
        #else
        nil
        #endif
      }()
    ),
  ]
}
