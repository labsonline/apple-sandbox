//
//  DestinationListingView.swift
//  iTour
//
//  Created by Schubert Anselme on 2025-07-21.
//

import SwiftUI
import SwiftData

struct DestinationListingView: View {
  @Environment(\.modelContext) var modelContext
  @State private var defaultSortOrder = [
    SortDescriptor(\Destination.name),
    SortDescriptor(\Destination.date),
  ]
  @Query var destinations: [Destination]
  
  init(sort: SortDescriptor<Destination>, searchString: String) {
    _destinations = Query(
      filter: #Predicate {
        if searchString.isEmpty {
          return true
        } else {
          return $0.name.localizedStandardContains(
            searchString
          )
        }
      },
      sort: [sort] + defaultSortOrder)
  }

  var body: some View {
    List {
      ForEach(destinations) { destination in
        NavigationLink(value: destination) {
          VStack(alignment: .leading) {
            Text(destination.name)
              .font(.headline)
            Text(destination.date.formatted(date: .long, time: .shortened))
          }
        }
      }
      .onDelete(perform: deleteDestination)
    }
  }

  func deleteDestination(_ indexSet: IndexSet) {
    for index in indexSet {
      let destination = destinations[index]
      modelContext.delete(destination)
    }
  }
}

#Preview {
  do {
    let context = try sample()
    return DestinationListingView(sort: SortDescriptor(\Destination.name), searchString: "")
      .modelContext(context)
  } catch {
    fatalError("Failed to create model container.")
  }
}
