import Combine
import SwiftUI
import EventKit

class AcademicScheduleViewModel: ObservableObject {
    @Published var courses: [Course] = []
    // @Published var assignments: [Assignment] = [] // Uncomment if you want to store assignments globally in this ViewModel.
    var dataFetcher: AcademicDataFetching

    init(dataFetcher: AcademicDataFetching) {
        self.dataFetcher = dataFetcher
        fetchCourses()
    }
    
    func fetchCourses() {
        dataFetcher.fetchCourses { [weak self] fetchedCourses in
            DispatchQueue.main.async {
                self?.courses = fetchedCourses
            }
        }
    }

    // Ensure this function is correctly enclosed within the class scope
    func fetchAssignments(forCourseId courseId: Int, completion: @escaping ([Assignment]) -> Void) {
        dataFetcher.fetchAssignments(forCourseId: courseId) { fetchedAssignments in
            DispatchQueue.main.async {
                // If you have a global assignments variable, update it here:
                // self?.assignments = fetchedAssignments
                // Otherwise, use the completion handler to return fetched assignments:
                completion(fetchedAssignments)
            }
        }
    }
}






