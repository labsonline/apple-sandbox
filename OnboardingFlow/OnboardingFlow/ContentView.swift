//
//  ContentView.swift
//  OnboardingFlow
//
//  Created by Schubert Anselme on 2026-01-05.
//

import SwiftUI

let gradientColors: [Color] = [
  .gradienTop,
  .gradientBottom,
]

struct ContentView: View {
  var body: some View {
    TabView {
      WelcomePage()
      FeaturePage()
    }
    .background(Gradient(colors: gradientColors))
#if os(iOS) || os(tvOS) || os(watchOS)
    .tabViewStyle(.page)
#else
    .tabViewStyle(.automatic)
#endif
    .foregroundStyle(.white)
  }
}

#Preview {
  ContentView()
}
