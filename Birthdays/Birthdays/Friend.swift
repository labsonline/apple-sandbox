//
//  Friend.swift
//  Birthdays
//
//  Created by Schubert Anselme on 2026-01-06.
//

import Foundation
import SwiftData

@Model
class Friend {
  var name: String
  var birthday: Date

  var isBirthdayToday: Bool {
    Calendar.current.isDateInToday(birthday)
  }

  init(name: String, birthday: Date) {
    self.name = name
    self.birthday = birthday
  }
}
