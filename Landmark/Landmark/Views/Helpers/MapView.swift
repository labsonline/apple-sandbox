//
//  MapView.swift
//  Landmark
//
//  Created by Schubert Anselme on 2025-06-17.
//

import SwiftUI
import MapKit

struct MapView: View {
  var coordinate: CLLocationCoordinate2D

  @AppStorage("MapView.zoom")
  private var zoom: Zoom = .medium

  var delta: CLLocationDegrees {
    switch zoom {
    case .near: 0.02
    case .medium: 0.2
    case .far: 2.0
    }
  }

  var body: some View {
    Map(position: .constant(.region(region)))
  }
  
  private var region: MKCoordinateRegion {
    MKCoordinateRegion(
      center: coordinate,
      span: MKCoordinateSpan(latitudeDelta: delta, longitudeDelta: delta)
    )
  }

  enum Zoom: String, CaseIterable, Identifiable {
    var id: Zoom { self }

    case near = "Near"
    case medium = "Medium"
    case far = "Far"
  }
}

#Preview {
  MapView(coordinate: CLLocationCoordinate2D(latitude: 34.011_286, longitude: -116.166_868))
}
