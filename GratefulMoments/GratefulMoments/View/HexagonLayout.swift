//
//  HexagonLayout.swift
//  GratefulMoments
//
//  Created by Schubert Anselme on 2026-01-09.
//

import SwiftUI

enum HexagonLayout {
  case standard
  case large

  var textBottomPadding: CGFloat { 0.25 }
  var timestampBottomPadding: CGFloat { 0.08 }
  var timestampHeight: CGFloat {
    size * (textBottomPadding - timestampBottomPadding)
  }

  var size: CGFloat {
    switch self {
    case .standard: return 200.0
    case .large: return 350.0
    }
  }

  var titleFont: Font {
    switch self {
    case .standard: return .headline
    case .large: return .title.bold()
    }
  }

  var bodyFont: Font {
    switch self {
    case .standard: return .caption2
    case .large: return .body
    }
  }
}
