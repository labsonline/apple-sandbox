//
//  ContentView.swift
//  WeatherForecast
//
//  Created by Schubert Anselme on 2025-06-26.
//

import SwiftUI

struct DayForecast: View {
  let day: String
  let isRainy: Bool
  let high: Int
  let low: Int
  
  var iconName: String { isRainy ? "cloud.rain.fill" : "sun.max.fill" }
  var iconColor: Color { isRainy ? .blue : .yellow }

  var body: some View {
    VStack {
      Text(day)
        .font(.headline)
      Image(systemName: iconName)
        .foregroundStyle(iconColor)
        .font(.largeTitle)
        .padding(5)
      Text("High: \(high)")
        .fontWeight(.semibold)
      Text("Low: \(low)")
        .fontWeight(.medium)
        .foregroundStyle(.secondary)
    }
    .padding()
  }
}

struct ContentView: View {
  var body: some View {
    HStack {
      DayForecast(day: "Mon", isRainy: false, high: 70, low: 50)
      DayForecast(day: "Tue", isRainy: true, high: 60, low: 40)
    }
  }
}

#Preview {
  ContentView()
}
