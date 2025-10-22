  //
  //  Issue.swift
  //  Portfolio
  //
  //  Created by Schubert Anselme on 2025-09-22.
  //

import Foundation
import SwiftData

enum Priority: Int {
  case low = 0
  case medium = 1
  case high = 2
}

@Model
final class Issue: Comparable {
  var id: UUID = UUID()
  var title: String = ""
  var content: String = ""
  var priority: Priority = Priority.low
  var completed: Bool = false
  var creationDate: Date = Date.now
  var modificationDate: Date = Date.now

  @Relationship var tags: [Tag]? = nil

  var issueStatus: String { completed ? "Closed" : "Open" }
  var issueTags: [Tag] { (tags ?? []).sorted() }
  var issueTagList: String {
    guard let tags else { return "No Tags" }
    if tags.count == 0 {
      return "No Tags"
    } else {
      return tags.map(\.name).formatted()
    }
  }

  init(
    id: UUID = .init(),
    title: String,
    content: String,
    priority: Priority = .low,
    completed: Bool = false,
    creationDate: Date = .now,
    modificationDate: Date = .now,
    tags: [Tag]? = nil
  ) {
    self.id = id
    self.title = title
    self.content = content
    self.priority = priority
    self.completed = completed
    self.creationDate = creationDate
    self.modificationDate = modificationDate
    self.tags = tags
  }

  static func < (lhs: Issue, rhs: Issue) -> Bool {
    let left = lhs.title.lowercased()
    let right = rhs.title.lowercased()
    if left == right {
      return lhs.creationDate < rhs.creationDate
    } else {
      return left < right
    }
  }
}

  // MARK: - Extension

extension Priority: CaseIterable, Codable {}

  // MARK: - Sample

extension Issue {
  static var example: Issue {
    .init(title: "Example Issue",
          content: "This is an example issue.",
          priority: .medium)
  }
}
