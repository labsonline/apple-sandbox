//
//  MomentsView.swift
//  GratefulMoments
//
//  Created by Schubert Anselme on 2026-01-09.
//

import SwiftUI
import SwiftData

struct MomentsView: View {
  static let offsetAmount: CGFloat = 70.0

  @State private var showCreateMoment = false
  @Query(sort: \Moment.timestamp) private var moments: [Moment]

  var body: some View {
    NavigationStack {
      ScrollView {
        LazyVStack(spacing: 8, pinnedViews: .sectionHeaders) {
          Section {
            pathItems
              .frame(maxWidth: .infinity)
          } header: {
              streakHeader
          }
        }
      }
      .overlay {
        if moments.isEmpty {
          ContentUnavailableView {
            Label("No moments yet!", systemImage: "exclamationmark.circle.fill")
          } description: {
            Text("Post a note or photo to start filling this space with gratitude.")
          }
        }
      }
      .toolbar {
        ToolbarItem(placement: .primaryAction) {
          Button {
            showCreateMoment = true
          } label: {
            Image(systemName: "plus")
          }
          .sheet(isPresented: $showCreateMoment) {
            MomentEntryView()
          }
        }
      }
      .defaultScrollAnchor(.bottom, for: .initialOffset)
      .defaultScrollAnchor(.bottom, for: .sizeChanges)
      .defaultScrollAnchor(.top, for: .alignment)
      .navigationTitle("Grateful Moments")
    }
    .dynamicTypeSize(...DynamicTypeSize.xxxLarge)
  }
}

private extension MomentsView {
  @ViewBuilder var streakHeader: some View {
    let streak = StreakCalculator().calculateStreak(for: moments)
    if streak > 0 {
      HStack {
        Text(verbatim: "\(streak)")
        Text(Image(systemName: "flame.fill"))
          .foregroundStyle(.ember)
        Spacer()
      }
      .font(.subheadline)
      .padding()
    }
  }

  var pathItems: some View {
    ForEach(moments.enumerated(), id: \.0) { index, moment in
      NavigationLink {
        MomentDetailView(moment: moment)
      } label: {
        if moment == moments.last {
          MomentHexagonView(moment: moment, layout: .large)
        } else {
          MomentHexagonView(moment: moment)
            .offset(x: sin(Double(index) * .pi / 2) * Self.offsetAmount)
        }
      }
      .scrollTransition { content, phase in
        content
          .opacity(phase.isIdentity ? 1 : 0)
          .scaleEffect(phase.isIdentity ? 1 : 0.8)
      }
    }
  }
}

#Preview {
  MomentsView()
    .sampleDataContainer()
}

#Preview("No Moments") {
  MomentsView()
    .modelContainer(for: [Moment.self])
    .environment(DataContainer())
}
