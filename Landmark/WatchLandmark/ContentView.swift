//
//  ContentView.swift
//  WatchLandmarks Watch App
//
//  Created by Schubert Anselme on 2025-06-18.
//

import SwiftUI
import UserNotifications

struct ContentView: View {
  var body: some View {
    LandmarkList()
      .task {
        let center = UNUserNotificationCenter.current()
        _ = try? await center
          .requestAuthorization(options: [.alert, .sound, .badge])
      }
  }
}

#Preview {
  ContentView()
    .environment(ModelData())
}
