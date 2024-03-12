//
//  CourseView.swift
//  Smart Academics, Wellness, and Rest Planner



import SwiftUI

struct CoursesView: View {
    @ObservedObject var viewModel: AcademicScheduleViewModel

    var body: some View {
        NavigationView {
            List(viewModel.courses.filter { $0.enrollmentTermID == 346 }) { course in
                NavigationLink(destination: CourseAssignmentsView(course: course, dataFetcher: viewModel.dataFetcher, viewModel: viewModel)) {
                    HStack {
                        Text(course.name)
                        Spacer()
                        Text(course.priority.rawValue)
                            .foregroundColor(.gray)
                            .padding(.all, 5)
                            .background(Color.blue.opacity(0.2))
                            .cornerRadius(5)
                        }
                }
            }
            .navigationTitle("Courses")
        }
    }
}


struct AssignmentsView: View {
    let course: Course
    @State private var assignments: [Assignment] = []
    var dataFetcher: AcademicDataFetching

    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()

    var body: some View {
        List(assignments) { assignment in
            VStack(alignment: .leading) {
                Text(assignment.name).font(.headline)
                if let dueDate = assignment.dueAt {
                    Text("Due: \(dueDate, formatter: dateFormatter)").font(.subheadline)
                }
            }
        }
        .navigationTitle(course.name)
        .onAppear {
            fetchAssignments(forCourseId: course.id)
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

