//
//  ContentView.swift
//  ChatPrototype
//
//  Created by Schubert Anselme on 2025-06-26.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    VStack {
      Text("Knock, knock!")
        .padding()
        .background(.yellow, in: RoundedRectangle(cornerRadius: 8))
      Text("Who's there?")
        .padding()
        .background(.teal, in: RoundedRectangle(cornerRadius: 8))
    }
    .padding()
  }
}

#Preview {
  ContentView()
}
