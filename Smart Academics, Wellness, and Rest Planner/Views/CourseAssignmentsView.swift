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

    private let isoDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ" // Adjust this format to match your JSON date strings
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()

    init(course: Course, dataFetcher: AcademicDataFetching, viewModel: AcademicScheduleViewModel) {
        self.course = course
        self.dataFetcher = dataFetcher
        self.viewModel = viewModel
    }

    var body: some View {
        VStack {
            List(assignments, id: \.id) { assignment in // Ensure Assignment conforms to Identifiable
                VStack(alignment: .leading) {
                    Text(assignment.name).font(.headline)
                    if let dueDate = assignment.dueAt {
                        Text("Due: \(dateFormatter.string(from: dueDate))").font(.subheadline) // Fixed string interpolation
                    }
                }
            }

            Picker("Priority", selection: $selectedPriority) {
                ForEach(Course.Priority.allCases, id: \.self) { priority in
                    Text(priority.rawValue).tag(priority)
                }
            }
            .onChange(of: selectedPriority) {
                viewModel.updatePriority(forCourseId: course.id, to: $0)
            }
        }
        .navigationTitle(course.name)
        .onAppear {
            fetchAssignments(forCourseId: course.id)
            selectedPriority = course.priority
        }
    }

    private func fetchAssignments(forCourseId courseId: Int) {
        dataFetcher.fetchAssignments(forCourseId: courseId) { fetchedAssignments in
            let now = Date() // Current date and time
            let filteredAssignments = fetchedAssignments.filter { assignment in
                // Keep the assignment if it has not been submitted yet OR its due date is in the future
                (assignment.dueAt != nil && assignment.dueAt! > now)
            }
            
            DispatchQueue.main.async {
                self.assignments = filteredAssignments
            }
        }
    }


    private func decodeAssignments(from data: Data) {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(isoDateFormatter)

        do {
            let decodedAssignments = try decoder.decode([Assignment].self, from: data)
            DispatchQueue.main.async {
                self.assignments = decodedAssignments
            }
        } catch {
            print("Failed to decode assignments:", error)
        }
    }
}
