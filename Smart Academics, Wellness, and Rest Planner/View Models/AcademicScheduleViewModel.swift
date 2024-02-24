import Combine
import SwiftUI
import EventKit

class AcademicScheduleViewModel: ObservableObject {
    @Published var assignments: [Assignment] = []
    @Published var courses: [Course] = []
    var useMockData: Bool = true
    
    init() {
        if useMockData {
            loadMockData()
        } else {
            // Placeholder for future API integration
            print("API integration is pending.")
        }
    }
    
    private func loadMockData() {
        let formatter = ISO8601DateFormatter()
        
        // Create mock assignments for each course
        let assignmentFor125 = Assignment(id: 1, name: "First Assignment", description: "Introduction to Search Systems", createdAt: Date(), updatedAt: Date(), dueAt: formatter.date(from: "2024-03-10T23:59:00Z"), lockAt: Date(), unlockAt: Date(), courseId: 125, htmlUrl: "https://example.com/compsci125/first_assignment", submissionsDownloadUrl: "https://example.com/compsci125/first_assignment/submissions", assignmentGroupId: 125)
        
        let assignmentFor171 = Assignment(id: 2, name: "First Assignment", description: "AI Principles", createdAt: Date(), updatedAt: Date(), dueAt: formatter.date(from: "2024-04-05T23:59:00Z"), lockAt: Date(), unlockAt: Date(), courseId: 171, htmlUrl: "https://example.com/compsci171/first_assignment", submissionsDownloadUrl: "https://example.com/compsci171/first_assignment/submissions", assignmentGroupId: 171)
        
        let assignmentFor116 = Assignment(id: 3, name: "First Assignment", description: "Basics of Computational Photography", createdAt: Date(), updatedAt: Date(), dueAt: formatter.date(from: "2024-05-01T23:59:00Z"), lockAt: Date(), unlockAt: Date(), courseId: 116, htmlUrl: "https://example.com/compsci116/first_assignment", submissionsDownloadUrl: "https://example.com/compsci116/first_assignment/submissions", assignmentGroupId: 116)
        
        let assignmentFor161 = Assignment(id: 4, name: "First Assignment", description: "Algorithm Complexity Analysis", createdAt: Date(), updatedAt: Date(), dueAt: formatter.date(from: "2024-05-29T23:59:00Z"), lockAt: Date(), unlockAt: Date(), courseId: 161, htmlUrl: "https://example.com/compsci161/first_assignment", submissionsDownloadUrl: "https://example.com/compsci161/first_assignment/submissions", assignmentGroupId: 161)
        
        // Create courses with the respective assignments
        courses = [
            Course(id: 125, name: "CompSci 125: Next Generation Search Systems", assignments: [assignmentFor125]),
            Course(id: 171, name: "CompSci 171: Introduction to Artificial Intelligence", assignments: [assignmentFor171]),
            Course(id: 116, name: "CompSci 116: Computational Photography", assignments: [assignmentFor116]),
            Course(id: 161, name: "CompSci 161: Design and Analysis of Algorithms", assignments: [assignmentFor161])
        ]
        
        // Populate assignments array for the Course tab view
        assignments = courses.flatMap { $0.assignments }
    }
    
    // Placeholder for future functionality
    func fetchAssignments(forCourseIds courseIds: [Int], userId: String) {
        // This method is intended for future API integration
        print("API integration method is not yet implemented.")
    }
    
    // Placeholder for scheduling study sessions
    func scheduleStudySession(for assignment: Assignment) {
        // This functionality could be expanded to integrate with the device's calendar
        print("Scheduling study sessions is a planned feature.")
    }
}












