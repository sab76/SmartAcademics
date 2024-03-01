import SwiftUI
import Foundation

struct CourseAssignmentsView: View {
    let course: Course
    var dataFetcher: AcademicDataFetching
    @ObservedObject var viewModel: AcademicScheduleViewModel
    @State private var selectedPriority: Course.Priority = .low


    @State private var assignments: [Assignment] = []

    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()

    init(course: Course, dataFetcher: AcademicDataFetching, viewModel: AcademicScheduleViewModel) {
        self.course = course
        self.dataFetcher = dataFetcher
        self.viewModel = viewModel
    }

    var body: some View {
        VStack {
            List(assignments) { assignment in
                VStack(alignment: .leading) {
                    Text(assignment.name).font(.headline)
                    if let dueDate = assignment.dueAt {
                        Text("Due: \(dueDate, formatter: dateFormatter)").font(.subheadline)
                    }
                }
            }

            Picker("Priority", selection: $selectedPriority) {
                ForEach(Course.Priority.allCases, id: \.self) { priority in
                    Text(priority.rawValue).tag(priority)
                }
            }
            .onChange(of: selectedPriority) {
                viewModel.updatePriority(forCourseId: course.id, to: selectedPriority)
            }

        }
        .navigationTitle(course.name)
        .onAppear {
            fetchAssignments(forCourseId: course.id)
            selectedPriority = course.priority // Initialize selectedPriority here.
        }
    }

    private func fetchAssignments(forCourseId courseId: Int) {
        dataFetcher.fetchAssignments(forCourseId: courseId) { fetchedAssignments in
            DispatchQueue.main.async {
                self.assignments = fetchedAssignments
            }
        }
    }
}
