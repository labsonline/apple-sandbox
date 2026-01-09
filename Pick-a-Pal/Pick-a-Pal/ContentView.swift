//
//  ContentView.swift
//  Pick-a-Pal
//
//  Created by Schubert Anselme on 2026-01-06.
//

import SwiftUI

struct ContentView: View {
  @State private var names: [String] = []
  @State private var nameToAdd = ""
  @State private var pickedName = ""
  @State private var shouldRemovePickedName = false

  var body: some View {
    VStack {
      VStack {
        Image(systemName: "person.3.sequence.fill")
          .foregroundStyle(.appBackground)
          .symbolRenderingMode(.hierarchical)
        Text("Pick-a-Pal")
      }
      .font(.title)
      .bold()

      Text(pickedName.isEmpty ? " " : pickedName)
        .font(.title2)
        .bold()
        .foregroundStyle(.appBackground)

      List {
        ForEach(names, id: \.description) {name in
          Text(name)
        }
      }
      .clipShape(RoundedRectangle(cornerRadius: 8))

      TextField("Add Name", text: $nameToAdd)
        .autocorrectionDisabled()
        .onSubmit {
          if !nameToAdd.isEmpty {
            names.append(nameToAdd)
            nameToAdd = ""
          }
        }

      Divider()

      Toggle("Remove Picked Name", isOn: $shouldRemovePickedName)

      Button {
        if let randomName = names.randomElement() {
          pickedName = randomName
          if shouldRemovePickedName {
            names.removeAll() { name in (name == randomName) }
          }
        } else {
          pickedName = ""
        }
      }
      label: {
        Text("Pick Random Name")
          .padding(.vertical, 8)
          .padding(.horizontal, 16)
      }
      .buttonStyle(.borderedProminent)
      .tint(.appBackground)
      .foregroundStyle(.white)
      .font(.title2)
    }
    .padding()
  }
}

#Preview {
  ContentView()
}
