//
//  NoIssueView.swift
//  Portfolio
//
//  Created by Schubert Anselme on 2025-09-23.
//

import SwiftUI

struct NoIssueView: View {

  var body: some View {
    Text("No Issue Selected")
      .font(.title)
      .foregroundStyle(.secondary)

    Button("New Issue") {
      // TODO: make a new issue
    }
  }
}

#Preview {
  NoIssueView()
}
