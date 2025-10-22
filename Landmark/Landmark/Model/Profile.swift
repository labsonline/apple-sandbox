//
//  Profile.swift
//  Landmark
//
//  Created by Schubert Anselme on 2025-06-18.
//

import Foundation

struct Profile {
  enum Season: String, CaseIterable, Identifiable {
    var id: String { rawValue }

    case spring = "🌷"
    case summer = "🌞"
    case autumn = "🍂"
    case winter = "☃️"
  }
  
  static let `default` = Profile(username: "guest")

  var username: String
  var prefersNotifications = true
  var seasonalPhoto = Season.winter
  var goalDate = Date()
}
