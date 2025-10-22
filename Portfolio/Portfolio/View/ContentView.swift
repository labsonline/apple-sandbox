//
//  ContentView.swift
//  Portfolio
//
//  Created by Schubert Anselme on 2025-09-22.
//

import SwiftUI
import SwiftData

fileprivate let issuesCutoff: Date = Calendar.current.date(byAdding: .day, value: -1, to: .now)!

struct ContentView: View {
  @Environment(\.modelContext) private var context

  @Query(filter: #Predicate<Issue> { $0.modificationDate > issuesCutoff })
  private var allIssues: [Issue]

  @Query private var allTags: [Tag]
  @State private var visibleIssues: [Issue] = []

  @Binding var selectedFilter: Filter?
  @Binding var selectedIssue: Issue?

  var body: some View {
    List(selection: $selectedIssue) {
      ForEach(visibleIssues) { issue in
        IssueRow(issue: issue)
      }
      .onDelete(perform: delete)
    }
    .navigationTitle("Issues")
    .onAppear { recalcIssues() }
    .onChange(of: selectedFilter) { recalcIssues() }
    .onChange(of: allIssues) { recalcIssues() }
    .onChange(of: allTags) { recalcIssues() }
  }
}

// MARK: - Private

private extension ContentView {
  func recalcIssues() {
    let filter = selectedFilter ?? .all
    if let tagID = filter.tagID, let tag = tag(with: tagID) {
      visibleIssues = (tag.issues ?? []).sorted()
    } else {
      visibleIssues = allIssues.sorted()
    }
  }

  func tag(with id: UUID) -> Tag? {
    allTags.first(where: { $0.id == id })
  }

  func delete(_ offsets: IndexSet) {
    // Capture items first based on current visible list
    let items = offsets.compactMap { index in
      visibleIssues.indices.contains(index) ? visibleIssues[index] : nil
    }
    // Defer deletion to the next run loop to avoid publishing during SwiftUI's update cycle
    DispatchQueue.main.async {
      for item in items {
        context.delete(item)
      }
    }
  }
}

// MARK: - Preview

#Preview {
  NavigationStack {
    ContentView(selectedFilter: .constant(.all), selectedIssue: .constant(nil))
  }
}
