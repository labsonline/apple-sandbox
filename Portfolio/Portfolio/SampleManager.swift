  //
  //  DataController.swift
  //  Portfolio
  //
  //  Created by Schubert Anselme on 2025-09-22.
  //

import SwiftData

struct SampleManager {
  static func createSampleData(using context: ModelContext) {
    for i in 1...5 {
      let tag = Tag(name: "Tag \(i)")
      context.insert(tag)

      for j in 1...10 {
        let issue = Issue(title: "Issue \(i)-\(j)", content: "Description for Issue \(i)-\(j)")
        issue.completed = Bool.random()
        issue.priority = Priority.allCases.randomElement() ?? .low

        if tag.issues == nil { tag.issues = [] }
        tag.issues?.append(issue)
        context.insert(issue)
      }

      try? context.save()
    }
  }

  static func deleteAll(in context: ModelContext) {
    deleteAll(Tag.self, in: context)
    deleteAll(Issue.self, in: context)
  }
}

// MARK: - Private

private extension SampleManager {
  static func deleteAll<T: PersistentModel>(_ type: T.Type = T.self, in context: ModelContext) {
    do {
      let descriptor = FetchDescriptor<T>()
      let items = try context.fetch(descriptor)
      for item in items { context.delete(item) }
      try context.save()
    } catch {
      print("Failed to delete all items of type \(T.self): \(error)")
    }
  }
}
