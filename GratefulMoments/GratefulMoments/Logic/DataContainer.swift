//
//  DataContainer.swift
//  GratefulMoments
//
//  Created by Schubert Anselme on 2026-01-08.
//

import SwiftData
import SwiftUI

private let sampleContainer = DataContainer(includeSampleMoments: true)

@Observable
class DataContainer {
  let modelContainer: ModelContainer
  var badgeManager: BadgeManager

  var context: ModelContext {
    modelContainer.mainContext
  }

  init(includeSampleMoments: Bool = false) {
    let schema = Schema([Moment.self, Badge.self])
    let modelConfiguration = ModelConfiguration(schema: schema,
                                                isStoredInMemoryOnly: includeSampleMoments)

    do {
      modelContainer = try ModelContainer(for: schema, configurations: [modelConfiguration])
      badgeManager = BadgeManager(modelContainer: modelContainer)

      _ = badgeManager.loadBadgeIfNeeded()

      if includeSampleMoments {
        loadSampleData()
      }

      try context.save()
    } catch {
      fatalError("Could not create ModelContainer: \(error)")
    }
  }
}

extension View {
  func sampleDataContainer() -> some View {
    self
      .environment(sampleContainer)
      .modelContainer(sampleContainer.modelContainer)
  }
}

private extension DataContainer {
  func loadSampleData() {
    for moment in Moment.sampleData {
      context.insert(moment)
      _ = badgeManager.unlockBadges(newMoment: moment)
    }
  }
}
