//
//  ChartView.swift
//  HikingSurvey
//
//  Created by Schubert Anselme on 2026-02-05.
//

import SwiftUI
import Charts

struct ChartView: View {
  var responses: [Response]

  var body: some View {
    Chart(responses) { response in
      SectorMark(angle: .value("Type", 1), innerRadius: .ratio(0.75))
        .foregroundStyle(by: .value("sentiment", response.sentiment))
    }
    .chartForegroundStyleScale([
      Sentiment.positive: Sentiment.positive.sentimentColor,
      Sentiment.negative: Sentiment.negative.sentimentColor,
      Sentiment.moderate: Sentiment.moderate.sentimentColor,
    ])
    .chartBackground { chartProxy in
      GeometryReader { geometry in
        if let anchor = chartProxy.plotFrame {
          let frame = geometry[anchor]
          Image(systemName: "figure.hiking")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(height: frame.height * 0.4)
            .foregroundStyle(Color(white: 0.59))
            .position(x: frame.midX, y: frame.midY)
        }
      }
    }
    .chartLegend(position: .trailing, alignment: .center)
    .frame(height: 200)
    .padding()
  }

  init(responses: [Response]) {
    self.responses = responses.sorted { $0.score < $1.score }
  }
}

#Preview {
  ChartView(responses: [])
}
