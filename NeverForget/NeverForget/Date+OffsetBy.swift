//
//  DateOffsetBy.swift
//  NeverForget
//
//  Created by Schubert Anselme on 2025-09-24.
//

import Foundation

extension Date {
  func offsetBy(days: Int, seconds: Int) -> Date {
    var dateComponents = DateComponents()
    dateComponents.day = days
    dateComponents.second = seconds
    return Calendar.current.date(byAdding: dateComponents, to: self) ?? self
  }
}
