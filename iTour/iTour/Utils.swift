//
//  Utils.swift
//  iTour
//
//  Created by Schubert Anselme on 2025-07-21.
//

import Foundation
import SwiftUI
import SwiftData

func sample() throws -> ModelContext {
  let config = ModelConfiguration(isStoredInMemoryOnly: true)
  let container = try ModelContainer(for: Destination.self, configurations: config)
  let context = ModelContext(container)
  
  let rome = Destination(name: "Rome")
  let florence = Destination(name: "Florence")
  let naples = Destination(name: "Naples")
  
  context.insert(rome)
  context.insert(florence)
  context.insert(naples)
  
  return context
}
