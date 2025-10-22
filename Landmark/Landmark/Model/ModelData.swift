//
//  ModelData.swift
//  Landmark
//
//  Created by Schubert Anselme on 2025-06-17.
//

import Foundation

@Observable
class ModelData {
  var landmarks: [Landmark] = load("landmarkData.json")
  var hikes: [Hike] = load("hikeData.json")
  var profile = Profile.default

  var features: [Landmark] {
    landmarks.filter { $0.isFeatured }
  }

  var categories: [String: [Landmark]] {
    Dictionary(grouping: landmarks, by: { $0.category.rawValue })
  }
}

func load<T>(_ filename: String) -> T where T: Decodable {
  let data: Data
  
  guard let file = Bundle.main.url(forResource: filename, withExtension: nil) else {
    fatalError("Could not find \(filename) in main bundle.")
  }
  
  do {
    data = try Data(contentsOf: file)
  } catch {
    fatalError("Coult not load \(filename) from main bundle:\n\(error)")
  }
  
  do {
    let decoder = JSONDecoder()
    return try decoder.decode(T.self, from: data)
  } catch {
    fatalError("Could not parse \(filename) as \(T.self):\n\(error)")
  }
}
