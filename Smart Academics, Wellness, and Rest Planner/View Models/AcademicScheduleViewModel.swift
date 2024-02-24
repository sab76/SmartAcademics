//
//  AcademicScheduleViewModel.swift
//  Smart Academics, Wellness, and Rest Planner
//
//  Created by Haley Marts on 2/22/24.
//
// Define AcademicItem
//all the types defined in Foundation framework are available to use in my Swift file
import Foundation
import Combine

class AcademicScheduleViewModel: ObservableObject {
    @Published var assignments: [Assignment] = []

    // Modify your fetch function to accept multiple course IDs
    func fetchAssignments(forCourseIds courseIds: [Int], userId: String) {
        assignments.removeAll() // Clear current assignments
        
        let group = DispatchGroup() // Use a dispatch group to track multiple requests
        
        for courseId in courseIds {
            group.enter() // Enter the group for each courseId
            
            CanvasAPIManager.shared.fetchAssignments(forCourseId: courseId, userId: userId) { [weak self] fetchedAssignments in
                DispatchQueue.main.async {
                    self?.assignments.append(contentsOf: fetchedAssignments)
                    group.leave() // Leave the group once assignments are fetched
                }
            }
        }
        
        group.notify(queue: .main) { // This block is called once all requests are completed
            // Here you can notify the UI that all assignments are fetched,
            // or perform further actions with the fetched assignments
            print("Fetched all assignments for provided course IDs.")
        }
    }
}

