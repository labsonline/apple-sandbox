//
//  PortfolioApp.swift
//  Portfolio
//
//  Created by Schubert Anselme on 2025-09-22.
//

import SwiftUI
import SwiftData

@main
struct PortfolioApp: App {
  @State private var selectedFilter: Filter? = .all
  @State private var selectedIssue: Issue?

  var body: some Scene {
    WindowGroup {
      NavigationSplitView {
        SideBarView(selectedFilter: $selectedFilter)
      } content: {
        ContentView(selectedFilter: $selectedFilter, selectedIssue: $selectedIssue)
      } detail: {
        DetailView(selectedIssue: $selectedIssue)
      }
    }
    .modelContainer(sharedCloudContainer)
  }
}

// MARK: - Private

private var sharedCloudContainer: ModelContainer = {
  let schema = Schema([Issue.self, Tag.self])
  let container: ModelContainer

  do {
    let cloudConfig = ModelConfiguration(schema: schema,
                                         isStoredInMemoryOnly: false,
                                         allowsSave: true,
                                         groupContainer: .none,
                                         cloudKitDatabase: .automatic)
    container = try ModelContainer(for: schema, configurations: [cloudConfig])
  } catch {
    fatalError("[SwiftData] CloudKit container creation failed: \(error)")
  }

  return container
}()
