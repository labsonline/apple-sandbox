//
//  IssueRow.swift
//  Portfolio
//
//  Created by Schubert Anselme on 2025-09-23.
//

import SwiftUI
import SwiftData

struct IssueRow: View {
  @Bindable var issue: Issue

  var body: some View {
    NavigationLink(value: issue) {
      HStack {
        Image(systemName: "exclamationmark.circle")
          .imageScale(.large)
          .opacity(issue.priority.rawValue == 2 ? 1 : 0)

        VStack(alignment: .leading) {
          Text(issue.title)
            .font(.headline)
            .lineLimit(1)

          Text(issue.issueTagList)
            .foregroundStyle(.secondary)
            .lineLimit(1)
        }

        Spacer()

        VStack(alignment: .trailing) {
          Text(issue.creationDate.formatted(date: .numeric, time: .omitted))
            .font(.subheadline)

          if issue.completed {
            Text("CLOSED")
              .font(.body.smallCaps())
          }
        }
        .foregroundStyle(.secondary)
      }
    }
  }
}

#Preview {
  IssueRow(issue: .example)
}
