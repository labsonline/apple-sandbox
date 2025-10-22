//
//  ContentView.swift
//  iTour
//
//  Created by Schubert Anselme on 2025-07-21.
//

import SwiftUI
import SwiftData

struct ContentView: View {
  @Environment(\.modelContext) var modelContext
  @State private var path = [Destination]()
  @State private var sortOrder = SortDescriptor(\Destination.name)
  @State private var searchText = ""
  //@State private var showAllDestinations = false

  var body: some View {
    NavigationStack(path: $path) {
      DestinationListingView(sort: sortOrder, searchString: searchText)
        .navigationTitle("iTour")
        .navigationDestination(for: Destination.self,
                               destination: EditDestinationView.init)
        .searchable(text: $searchText)
        .toolbar {
          Button("Add Destination", systemImage: "plus", action: addDestination)
          Menu("Sort", systemImage: "arrow.up.arrow.down") {
            //Picker("Show", selection: $showAllDestinations) {
            //  Text("All Sights")
            //  Text("Future Sights Only")
            //}
            Picker("Sort", selection: $sortOrder) {
              Text("Name").tag(SortDescriptor(\Destination.name))
              Text("Priority").tag(SortDescriptor(\Destination.priority, order: .reverse))
              Text("Date").tag(SortDescriptor(\Destination.date))
            }
            //.pickerStyle(.inline) // NOTE: does not do anything?
          }
        }
    }
  }

  func addDestination() {
    let destination = Destination()
    modelContext.insert(destination)
    path = [destination]
  }
}

#Preview {
  do {
    let context = try sample()
    return ContentView().modelContext(context)
  } catch {
    fatalError("Failed to create model container.")
  }
}
