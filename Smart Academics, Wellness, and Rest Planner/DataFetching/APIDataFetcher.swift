//
//  APIDataFetcher.swift
//  Smart Academics, Wellness, and Rest Planner
//
//  Created by Haley Marts on 2/24/24.
//
import SwiftUI
import CoreData
import EventKit


class APIDataFetcher: AcademicDataFetching {
    func fetchCourses(completion: @escaping ([Course]) -> Void) {
        // Will implement API call to fetch courses
        // Parse the JSON response and convert it to an array of Course objects
        // Call completion with the courses array
    }
    
    func fetchAssignments(forCourseId courseId: Int, completion: @escaping ([Assignment]) -> Void) {
        // Implement API call to fetch assignments for the specified course ID
        // Parse the JSON response and convert it to an array of Assignment objects
        // Call completion with the assignments array
    }
}


