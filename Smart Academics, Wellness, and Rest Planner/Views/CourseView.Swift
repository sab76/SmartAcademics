//
//  CourseView.Swift
//  Smart Academics, Wellness, and Rest Planner


import SwiftUI

struct CoursesView: View {
    @ObservedObject var viewModel: AcademicScheduleViewModel
    
    var body: some View {
        NavigationView {
            List(viewModel.courses) { course in
                NavigationLink(destination: AssignmentsView(course: course)) {
                    Text(course.name)
                }
            }
            .navigationTitle("Courses")
        }
    }
}

struct AssignmentsView: View {
    var course: Course

    var body: some View {
        List(course.assignments) { assignment in
            VStack(alignment: .leading) {
                Text(assignment.name).font(.headline)
                // will display other assignment details 
            }
        }
        .navigationTitle(course.name)
    }
}


