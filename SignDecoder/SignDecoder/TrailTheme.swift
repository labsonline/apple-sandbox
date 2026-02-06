//
//  TrailTheme.swift
//  SignDecoder
//
//  Created by Schubert Anselme on 2026-02-06.
//

import Foundation
import SwiftUI

struct TrailTheme: ViewModifier {
  func body(content: Content) -> some View {
    ZStack {
      VStack {
        Image(.background)
          .resizable()
          .edgesIgnoringSafeArea(.all)
          .frame(maxHeight: 250, alignment: .top)
        Spacer()
      }
      content
    }
  }
}

extension View {
  func trailTheme() -> some View {
    modifier(TrailTheme())
  }
}
