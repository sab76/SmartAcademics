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







