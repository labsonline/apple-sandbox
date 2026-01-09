//
//  DetailView.swift
//  Portfolio
//
//  Created by Schubert Anselme on 2025-09-22.
//

import SwiftUI

struct DetailView: View {
  @Binding var selectedIssue: Issue?

  var body: some View {
    VStack {
      if let issue = selectedIssue {
        IssueView(issue: issue)
      } else {
        NoIssueView()
      }
    }
    .navigationTitle("Details")
#if os(iOS)
    .navigationBarTitleDisplayMode(.inline)
#endif
  }
}

// MARK: - Preview

#Preview {
  NavigationStack {
    DetailView(selectedIssue: .constant(nil))
  }
}
