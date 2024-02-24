//
//  AssignmentDetailView.swift
//  Smart Academics, Wellness, and Rest Planner


import Foundation
import SwiftUI
import EventKit

struct AssignmentDetailView: View {
    let assignment: Assignment
    var isAccessGranted: Bool
    var eventStore: EKEventStore

    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()

    var body: some View {
        VStack(spacing: 20) {
            Text(assignment.name)
                .font(.title)
            Text(assignment.description ?? "No additional details")
                .padding()
            if let dueDate = assignment.dueAt {
                Text("Due: \(dueDate, formatter: dateFormatter)")
            }
            if isAccessGranted {
                Button("Schedule Study Session") {
                    scheduleStudySession(for: assignment)
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            } else {
                Text("Calendar access not granted. Please enable access in Settings.")
                    .foregroundColor(.red)
            }
        }
        .padding()
    }

    func scheduleStudySession(for assignment: Assignment) {
        guard let dueDate = assignment.dueAt, isAccessGranted else { return }
        
        let event = EKEvent(eventStore: eventStore)
        event.title = "Study Session for \(assignment.name)"
        event.startDate = Calendar.current.date(byAdding: .day, value: -3, to: dueDate)
        event.endDate = event.startDate?.addingTimeInterval(2 * 60 * 60) // 2 hours
        event.calendar = eventStore.defaultCalendarForNewEvents
        
        do {
            try eventStore.save(event, span: .thisEvent)
            // Ideally, plan to provide user feedback about the scheduled session, such as a confirmation alert.
            print("Study session scheduled in your calendar.")
        } catch {
            // Handle errors, possibly with a user alert.
            print("Failed to save the event: \(error.localizedDescription)")
        }
    }
}
