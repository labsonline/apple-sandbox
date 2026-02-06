//
//  PredictionView.swift
//  TrailAnalyzer
//
//  Created by Schubert Anselme on 2026-02-06.
//

import SwiftUI

struct PredictionView: View {
  @State var predictedRisk: Risk

  var body: some View {
    VStack {
      RiskCard(risk: predictedRisk)
      Spacer()
    }
    .navigationTitle("Results")
    .navigationBarTitleDisplayMode(.large)
    .toolbar {
      ToolbarItem(placement: .topBarTrailing) {
        NavigationLink { riskSummaryView } label: {
          Image(systemName: "info.circle")
        }
      }
    }
    .trailTheme()
  }
}

extension PredictionView {
  var riskSummaryView: some View {
    ScrollView {
      ForEach(Risk.allCases) { RiskCard(risk: $0) }
    }
  }
}

#Preview {
  NavigationStack {
    PredictionView(predictedRisk: .moderate)
  }
}
