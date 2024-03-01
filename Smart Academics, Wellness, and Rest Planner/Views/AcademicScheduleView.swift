import Foundation
import SwiftUI
import EventKit

struct AcademicScheduleView: View {
    @StateObject private var viewModel: AcademicScheduleViewModel
    @State private var isAccessGranted = false
    private let eventStore = EKEventStore()

    init(dataFetcher: AcademicDataFetching) {
        _viewModel = StateObject(wrappedValue: AcademicScheduleViewModel(dataFetcher: dataFetcher))
    }

    var body: some View {
        NavigationView {
            List(viewModel.courses) { course in
                NavigationLink(destination: CourseAssignmentsView(course: course, dataFetcher: viewModel.dataFetcher, viewModel: viewModel)) {
                    Text(course.name)
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
}



 //   func scheduleStudySession(for assignment: Assignment) {
  //      guard let dueDate = assignment.dueAt, isAccessGranted else { return }
        
   //     let event = EKEvent(eventStore: eventStore)
  //      event.title = "Study Session for \(assignment.name)"
   //     event.startDate = Calendar.current.date(byAdding: .day, value: -3, to: dueDate)
    //    event.endDate = event.startDate?.addingTimeInterval(2 * 60 * 60) // 2 hours
    //    event.calendar = eventStore.defaultCalendarForNewEvents
        
    //    do {
     //       try eventStore.save(event, span: .thisEvent)
        //    print("Study session scheduled in your calendar.")
     //   } catch {
    //      print("Failed to save the event: \(error.localizedDescription)")
      //  }
    //}
//}





