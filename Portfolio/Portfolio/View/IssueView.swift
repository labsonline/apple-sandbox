  //
  //  IssueView.swift
  //  Portfolio
  //
  //  Created by Schubert Anselme on 2025-09-23.
  //

import SwiftUI
import SwiftData

struct IssueView: View {
  @Query private var allTags: [Tag]
  @Bindable var issue: Issue

  var body: some View {
    Form {
      Section {
        VStack(alignment: .leading) {
          TextField("Title", text: $issue.title, prompt: Text("Enter the issue title here"))
            .font(.title)
          Text("**Modified:** \(issue.modificationDate.formatted(date: .long, time: .shortened))")
            .foregroundStyle(.secondary)

          Text("**Status:** \(issue.issueStatus)")
            .foregroundStyle(.secondary)
        }

        Picker("Priority", selection: $issue.priority) {
          ForEach(Priority.allCases, id: \.self) { level in
            Text(Self.displayName(for: level)).tag(level)
          }
        }

        Menu {
          // Show selected tags first
          ForEach(issue.issueTags, id: \.self) { tag in
            Button {
              removeTag(tag)
            } label: {
              Label(tag.name, systemImage: "checkmark")
            }
          }

          // Add divider if there are selected tags and available tags to add
          if !issue.issueTags.isEmpty && !availableTags.isEmpty {
            Divider()

            // Show unselected tags
            Section("Add Tags") {
              ForEach(availableTags, id: \.self) { tag in
                Button(tag.name) { addTag(tag) }
              }
            }
          }
        } label: {
          Text(issue.issueTagList)
            .multilineTextAlignment(.leading)
            .frame(maxWidth: .infinity, alignment: .leading)
            .animation(nil, value: issue.issueTagList)
        }
      }

      Section {
        VStack(alignment: .leading) {
          Text("Basic Information")
            .font(.title2)
            .foregroundStyle(.secondary)

          TextField("Description",
                    text: $issue.content,
                    prompt: Text("Enter the issue description here"),
                    axis: .vertical)
        }
      }
    }
    .disabled(issue.isDeleted)
  }
}

// MARK: Private

private extension IssueView {
  var availableTags: [Tag] {
    allTags.filter { tag in !issue.issueTags.contains(tag) }
  }

  func addTag(_ tag: Tag) {
    if issue.tags == nil { issue.tags = [] }
    issue.tags?.append(tag)
    issue.modificationDate = .now
  }

  func removeTag(_ tag: Tag) {
    issue.tags?.removeAll { $0 == tag }
    issue.modificationDate = .now
  }

  private static func displayName(for priority: Priority) -> String {
    switch priority {
    case .low: return "Low"
    case .medium: return "Medium"
    case .high: return "High"
    }
  }
}

// MARK: Preview

#Preview {
  IssueView(issue: .example)
}
