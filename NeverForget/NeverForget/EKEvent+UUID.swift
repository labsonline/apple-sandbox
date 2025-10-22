//
//  EKEvent+UUID.swift
//  NeverForget
//
//  Created by Schubert Anselme on 2025-09-24.
//

import EventKit
import Foundation

extension EKEvent {
  var neverForgetID: UUID {
    UUID(uuidString: calendarItemIdentifier) ?? UUID()
  }
}
