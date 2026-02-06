//
//  BoundsRect.swift
//  SignDecoder
//
//  Created by Schubert Anselme on 2026-02-06.
//

import Foundation
import SwiftUI
import Vision

struct BoundsRect: Shape {
  let normalizeRect: NormalizedRect

  func path(in rect: CGRect) -> Path {
    let imageCoordinatesRect = normalizeRect.toImageCoordinates(rect.size, origin: .upperLeft)
    return Path(imageCoordinatesRect)
  }
}
