import Combine
import SwiftUI
import EventKit

class AcademicScheduleViewModel: ObservableObject {
    @Published var courses: [Course] = []
    @Published var assignmentsByCourseId: [Int: [Assignment]] = [:] // Maps course IDs to their assignments
    
    var dataFetcher: AcademicDataFetching

    init(dataFetcher: AcademicDataFetching) {
        self.dataFetcher = dataFetcher
        fetchCoursesAndAssignments()
    }
    
    func fetchCourses() {
        dataFetcher.fetchCourses { [weak self] fetchedCourses in
            DispatchQueue.main.async {
                self?.courses = fetchedCourses
            }
        }
    }

    // New function to fetch both courses and their assignments
    private func fetchCoursesAndAssignments() {
        fetchCourses()
        
        // After courses are fetched, fetch assignments for each course
        dataFetcher.fetchCourses { [weak self] fetchedCourses in
            DispatchQueue.main.async {
                self?.courses = fetchedCourses
                fetchedCourses.forEach { course in
                    self?.fetchAssignments(forCourseId: course.id)
                }
            }
        }
    }
    
    func fetchAssignments(forCourseId courseId: Int) {
        dataFetcher.fetchAssignments(forCourseId: courseId) { [weak self] fetchedAssignments in
            DispatchQueue.main.async {
                self?.assignmentsByCourseId[courseId] = fetchedAssignments
            }
        }
    }
    
    func updatePriority(forCourseId id: Int, to newPriority: Course.Priority) {
        if let index = courses.firstIndex(where: { $0.id == id }) {
            courses[index].priority = newPriority
            // Optionally, save the updated course list to your data store or backend here.
        }
    }
}
