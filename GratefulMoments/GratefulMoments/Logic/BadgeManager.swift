  //
  //  BadgeManager.swift
  //  GratefulMoments
  //
  //  Created by Schubert Anselme on 2026-01-09.
  //

import Foundation
import SwiftData

class BadgeManager {
  private let modelContainer: ModelContainer

  init(modelContainer: ModelContainer) {
    self.modelContainer = modelContainer
  }

  func loadBadgeIfNeeded() -> Result<(), Error> {
    let context = modelContainer.mainContext
    let existingBadges: [Badge]

    var fetchDescriptor = FetchDescriptor<Badge>()

    fetchDescriptor.fetchLimit = 1

    do {
      existingBadges = try context.fetch(fetchDescriptor)
    } catch {
      return .failure(error)
    }

    if existingBadges.isEmpty {
      for details in BadgeDetails.allCases {
        context.insert(Badge(details: details))
      }
    }

    return .success(())
  }

  func unlockBadges(newMoment: Moment) -> Result<(), Error> {
    let context = modelContainer.mainContext
    let moments: [Moment]
    let lockedBadges: [Badge]

    var newlyUnlocked: [Badge] = []

    do {
      moments = try context.fetch(FetchDescriptor<Moment>())
      lockedBadges = try context.fetch(FetchDescriptor<Badge>(predicate: #Predicate { $0.timestamp == nil }))
    } catch {
      return .failure(error)
    }

    for badge in lockedBadges {
      switch badge.details {
      case .firstEntry where moments.count >= 1,
          .fiveStars where moments.count >= 5,
          .shutterbug where moments.count(where: { $0.image != nil }) >= 3,
          .expressive where moments.count(where: { $0.image != nil && !$0.note.isEmpty }) >= 5,
          .perfectTen where moments.count >= 10 && lockedBadges.count == 1:
        newlyUnlocked.append(badge)
      default:
        continue
      }
    }

    for badge in newlyUnlocked {
      badge.moment = newMoment
      badge.timestamp = newMoment.timestamp
    }

    return .success(())
  }
}
