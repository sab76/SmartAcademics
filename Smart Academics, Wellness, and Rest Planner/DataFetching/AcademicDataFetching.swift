//
//  AcademicDataFetching.swift
//  Smart Academics, Wellness, and Rest Planner
//
//  Created by Haley Marts on 2/24/24.
//

import Foundation

// Define a protocol that your data fetchers will conform to
protocol AcademicDataFetching {
    // Function to fetch a list of courses
    func fetchCourses(completion: @escaping ([Course]) -> Void)
    
    // Function to fetch assignments for a given course ID
    func fetchAssignments(forCourseId courseId: Int, completion: @escaping ([Assignment]) -> Void)
}

