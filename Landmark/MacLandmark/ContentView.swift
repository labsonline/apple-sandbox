//
//  ContentView.swift
//  MacLandmarks
//
//  Created by Schubert Anselme on 2025-06-18.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    LandmarkList()
      .frame(minWidth: 700, minHeight: 300)
  }
}

#Preview {
  ContentView()
    .environment(ModelData())
}
