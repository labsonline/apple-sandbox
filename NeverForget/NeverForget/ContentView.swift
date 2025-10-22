//
//  ContentView.swift
//  NeverForget
//
//  Created by Schubert Anselme on 2025-09-24.
//

import AlarmKit
import EventKit
import SwiftUI

struct NeverForgetData: AlarmMetadata {}

struct ContentView: View {
  @Environment(\.scenePhase) private var scenePhase

  @State private var eventStore = EKEventStore()
  @State private var events = [EKEvent]()
  @State private var alarms = [UUID]()

  var body: some View {
    NavigationStack {
      List(events, id: \.eventIdentifier) { event in
        Button {
          toggleAlarm(for: event)
        } label: {
          HStack {
            VStack(alignment: .leading) {
              Text(event.title)
              Text(event.startDate, format: .dateTime.month().day().hour().minute())
            }

            Spacer()

            if alarms.contains(event.neverForgetID) {
              Image(systemName: "checkmark")
                .foregroundStyle(.green)
            }
          }
        }
      }
      .navigationTitle("Never Forget")
    }
    .onChange(of: scenePhase) {
      if scenePhase == .active {
        Task { try await loadEvents() }
      }
    }
    .onAppear(perform: startWatchingAlarms)
  }

  func loadEvents() async throws {
    guard try await eventStore.requestFullAccessToEvents() else { return }

    let endDate = Date.now.offsetBy(days: 90, seconds: 0)
    let predicate = eventStore.predicateForEvents(withStart: .now,
                                                  end: endDate,
                                                  calendars: nil)
    let rawEvents = eventStore.events(matching: predicate)

    let grouped = Dictionary(grouping: rawEvents, by: \.calendarItemIdentifier)
    let firstInstances = grouped.compactMap { _, events in
      events.min { $0.startDate < $1.startDate }
    }

    events = firstInstances.sorted { $0.startDate < $1.startDate }
  }

  func startWatchingAlarms() {
    Task {
      for await update in AlarmManager.shared.alarmUpdates {
        alarms = update.map(\.id)
      }
    }
  }

  func scheduleAlarm(for event: EKEvent) async throws {
    // let components = Calendar.current.dateComponents([.hour, .minute],
    //                                                  from: event.startDate)
    // let hour = components.hour ?? 0
    // let minute = components.minute ?? 0
   
    // let time = Alarm.Schedule.Relative.Time(hour: hour, minute: minute)
    // let relativeSchedule = Alarm.Schedule.Relative(time: time, repeats: .never)
    // let schedule = Alarm.Schedule.relative(relativeSchedule)

    let schedule = Alarm.Schedule.fixed(event.startDate)
    let alert = AlarmPresentation.Alert(title: .init(stringLiteral: event.title),
                                        stopButton: AlarmButton(text: "Stop",
                                                                textColor: .blue,
                                                                systemImageName: "stop.circle"))

    let presentation = AlarmPresentation(alert: alert)
    let attributes = AlarmAttributes(presentation: presentation,
                                     metadata: NeverForgetData(),
                                     tintColor: .blue)
    let configuration = AlarmManager.AlarmConfiguration(schedule: schedule,
                                                        attributes: attributes)

    do {
      let newAlarm = try await AlarmManager.shared.schedule(id: event.neverForgetID,
                                                            configuration: configuration)
      print("Scheduled: \(newAlarm.id)")
    } catch {
      print(error)
    }
  }

  func unscheduleAlarm(for event: EKEvent) {
    try? AlarmManager.shared.cancel(id: event.neverForgetID)
  }

  func toggleAlarm(for event: EKEvent) {
    Task {
      if alarms.contains(event.neverForgetID) {
        unscheduleAlarm(for: event)
      } else {
        try await scheduleAlarm(for: event)
      }
    }
  }
}

#Preview {
  ContentView()
}
