//
//  PageControl.swift
//  Landmark
//
//  Created by Schubert Anselme on 2025-06-18.
//

import SwiftUI
import UIKit

struct PageControl: UIViewRepresentable {
  var numberOfPages: Int
  @Binding var currentPage: Int

  @MainActor
  class Coordinator: NSObject {
    var control: PageControl

    init(_ control: PageControl) {
      self.control = control
    }

    @objc
    func updateCurrentPage(sender: UIPageControl) {
      control.currentPage = sender.currentPage
    }
  }

  func makeCoordinator() -> Coordinator {
    Coordinator(self)
  }

  func makeUIView(context: Context) -> UIPageControl {
    let control = UIPageControl()
    control.numberOfPages = numberOfPages
    control.addTarget(context.coordinator,
                      action: #selector(Coordinator.updateCurrentPage(sender:)),
                      for: .valueChanged)
    return control
  }

  func updateUIView(_ uiView: UIPageControl, context: Context) {
    uiView.currentPage = currentPage
  }
}
