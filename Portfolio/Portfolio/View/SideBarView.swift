  //
  //  SideBarView.swift
  //  Portfolio
  //
  //  Created by Schubert Anselme on 2025-09-22.
  //

import SwiftData
import SwiftUI

struct SideBarView: View {
  let smartFilters: [Filter] = [.all, .recent]

  @Environment(\.modelContext) private var context
  @Query(sort: \Tag.name) private var tags: [Tag]

  @Binding var selectedFilter: Filter?

  var tagFilters: [Filter] {
    let mapped: [Filter] = tags.map { (tag: Tag) -> Filter in
      return Filter(id: tag.id, name: tag.name, icon: "tag", tagID: tag.id)
    }
    return mapped
  }

  var body: some View {
    List(selection: $selectedFilter) {
      Section("Smart Filters") {
        ForEach(smartFilters) { filter in
          NavigationLink(value: filter) {
            Label(filter.name, systemImage: filter.icon)
          }
        }
      }

      Section("Tags") {
        ForEach(tagFilters) { filter in
          NavigationLink(value: filter) {
            Label(filter.name, systemImage: filter.icon)
              .badge(activeIssueCount(for: filter))
          }
        }
        .onDelete(perform: delete)
      }
    }
    .toolbar {
      Button {
        SampleManager.deleteAll(in: context)
        SampleManager.createSampleData(using: context)
      } label: {
        Label("ADD SAMPLES", systemImage: "flame")
      }
    }
  }

  func delete(_ offsets: IndexSet) {
    for offset in offsets {
      let item = tags[offset]
      context.delete(item)
    }
  }
}

// MARK: - Private

private extension SideBarView {
  private func activeIssueCount(for filter: Filter) -> Int {
    // Prefer looking up the Tag by id to avoid heavy type inference on optional chaining in the ViewBuilder
    guard let tagID = filter.tagID else { return 0 }
    if let tag = tags.first(where: { $0.id == tagID }) {
      return tag.tagActiveIssues.count
    }
    return 0
  }
}

// MARK: - Preview

#Preview {
  NavigationStack {
    SideBarView(selectedFilter: .constant(.all))
  }
}

