//
//  ScheduleViewModel.swift
//  Smart Academics, Wellness, and Rest Planner
//
//  Created by Haley Marts on 2/23/24.
//

import Foundation
import Combine

class ScheduleViewModel: ObservableObject {
    @Published var assignments: [Assignment] = []
    
    func fetchAssignments(forCourseId courseId: Int, userId: String) {
        CanvasAPIManager.shared.fetchAssignments(forCourseId: courseId, userId: userId) { [weak self] fetchedAssignments in
            self?.assignments = fetchedAssignments
        }
    }
}
