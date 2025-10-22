//
//  RotatedBadgeSymbol.swift
//  Landmark
//
//  Created by Schubert Anselme on 2025-06-18.
//

import SwiftUI

struct RotatedBadgeSymbol: View {
  let angle: Angle

  var body: some View {
    BadgeSymbol()
      .padding(-60)
      .rotationEffect(angle, anchor: .bottom)
  }
}


#Preview {
  RotatedBadgeSymbol(angle: Angle(degrees: 5))
}
