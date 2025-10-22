//
//  Filter.swift
//  Portfolio
//
//  Created by Schubert Anselme on 2025-09-22.
//

import Foundation

struct Filter {
  var id: UUID
  var name: String
  var icon: String
  var minModificationDate = Date.distantPast
  var tagID: UUID?

  static var all = Filter(id: .init(), name: "All Issues", icon: "tray")
  static var recent = Filter(id: .init(),
                             name: "Recent Issues",
                             icon: "clock",
                             minModificationDate: .now.addingTimeInterval(86400 * -7))

  func hash(into hasher: inout Hasher) { hasher.combine(id) }
  static func ==(lhs: Filter, rhs: Filter) -> Bool { lhs.id == rhs.id }
}

// MARK: - Extension

extension Filter:
  Identifiable,
  Hashable
  {}
