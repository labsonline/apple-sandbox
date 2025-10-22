  //
  //  Tag.swift
  //  Portfolio
  //
  //  Created by Schubert Anselme on 2025-09-22.
  //

import Foundation
import SwiftData

@Model
final class Tag: Comparable {
  var id: UUID = UUID()
  var name: String = ""

  @Relationship(inverse: \Issue.tags) var issues: [Issue]? = nil

  var tagActiveIssues: [Issue] { (issues ?? []).filter { $0.completed == false } }
  static var example: Tag { .init(name: "Example Tag") }

  init(id: UUID = .init(), name: String = "", issues: [Issue]? = nil) {
    self.id = id
    self.name = name
    self.issues = issues
  }

  static func <(lhs: Tag, rhs: Tag) -> Bool {
    let left = lhs.name.lowercased()
    let right = rhs.name.lowercased()
    if left == right {
      return lhs.id.uuidString < rhs.id.uuidString
    } else {
      return left < right
    }
  }
}
