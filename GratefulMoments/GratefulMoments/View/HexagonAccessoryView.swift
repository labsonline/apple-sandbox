//
//  HexagonAccessoryView.swift
//  GratefulMoments
//
//  Created by Schubert Anselme on 2026-01-09.
//

import SwiftUI

struct HexagonAccessoryView: View {
  let moment: Moment
  let hexagonLayout: HexagonLayout

  var body: some View {
    NavigationLink {
      if badges.count == 1 {
        BadgeDetailView(badge: badges[0])
      } else {
        MomentDetailView(moment: moment)
      }
    } label: {
      badgeView
    }
  }
}

private extension HexagonAccessoryView {
  var badges: [Badge] { moment.badges }
  var size: CGFloat { hexagonLayout.size / 5 }

  var yOffset: CGFloat {
    let radius = hexagonLayout.size / 2

      // 30 degrees points to the top right corner of a hexagon
    let yOffsetFromHexagonCenter = sin(Angle.degrees(30).radians) * radius

    return radius - yOffsetFromHexagonCenter - (size / 2)
  }

  var badgeView: some View {
    Group {
      if badges.count > 1 {
        Text("+\(badges.count)")
          .bold()
          .minimumScaleFactor(0.3)
          .frame(width: size * 0.5, height: size * 0.5)
          .padding(8)
          .background {
            Image("Blank")
              .resizable()
              .frame(width: size, height: size)
              .shadow(radius: 2)
          }
          .foregroundStyle(.gray)
      } else if let badges = badges.first {
        Image(badges.details.image)
          .resizable()
          .frame(width: size, height: size)
          .shadow(radius: 2)
      }
    }
    .offset(y: yOffset)
  }
}

// #Preview {
//   MomentHexagonView(moment: .sample, layout: .large)
// }

#Preview("Single Badge") {
  MomentHexagonView(moment: .sample, layout: .large)
    .sampleDataContainer()
}

#Preview("Multiple Badge") {
  MomentHexagonView(moment: .imageSample, layout: .standard)
    .dynamicTypeSize(.large)
    .sampleDataContainer()
}
