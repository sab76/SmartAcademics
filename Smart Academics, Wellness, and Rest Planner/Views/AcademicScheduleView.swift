import Foundation
import SwiftUI
import EventKit

struct AcademicScheduleView: View {
    @StateObject private var viewModel = AcademicScheduleViewModel()
    @State private var isAccessGranted = false
    private let eventStore = EKEventStore()

    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()

    var body: some View {
        NavigationView {
            List(viewModel.assignments) { assignment in
                NavigationLink(destination: AssignmentDetailView(assignment: assignment, isAccessGranted: isAccessGranted, eventStore: eventStore)) {
                
                    VStack(alignment: .leading) {
                        Text(assignment.name).font(.headline)
                        if let dueDate = assignment.dueAt {
                            Text("Due: \(dueDate, formatter: dateFormatter)").font(.subheadline)
                        }
                    }
                }
            }
            .navigationTitle("Academic Schedule")
            .onAppear {
                requestCalendarAccess()
            }
        }
    }

    private func requestCalendarAccess() {
        
        eventStore.requestFullAccessToEvents { granted, error in
            DispatchQueue.main.async {
                self.isAccessGranted = granted
                if let error = error {
                    print("Error requesting calendar access: \(error.localizedDescription)")
                }
            }
        }
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
            print("Study session scheduled in your calendar.")
        } catch {
            print("Failed to save the event: \(error.localizedDescription)")
        }
    }
}



