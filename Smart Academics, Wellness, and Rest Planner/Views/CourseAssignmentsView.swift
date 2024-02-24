//
//  CourseAssignmentsView.swift
//  Smart Academics, Wellness, and Rest Planner
//
//  Created by Haley Marts on 2/24/24.
//

import SwiftUI
import Foundation

struct CourseAssignmentsView: View {
    let course: Course
    var dataFetcher: AcademicDataFetching

    @State private var assignments: [Assignment] = []

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
                // Include additional assignment details here
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

