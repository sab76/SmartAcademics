//
//  APIDataFetcher.swift
//  Smart Academics, Wellness, and Rest Planner
//
//  Created by Haley Marts on 2/24/24.
//
import SwiftUI
import CoreData
import EventKit
import Foundation

class APIDataFetcher: AcademicDataFetching {
    let accessToken = "4407~PcTNNysqfj5aXaHeGpFswT3SJEhf7iY8KDvxoguhYLVciBUu44zF8Low0B9CXpsw"
    let baseURL = "https://canvas.eee.uci.edu/api/v1/"
    
    func fetchCourses(completion: @escaping ([Course]) -> Void) {
        guard let url = URL(string: "\(baseURL)courses?access_token=\(accessToken)") else {
            print("Invalid URL")
            completion([])
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error fetching courses: \(error?.localizedDescription ?? "Unknown error")")
                completion([])
                return
            }
            
            do {
                // Create an instance of JSONDecoder
                let decoder = JSONDecoder()
                // Set the date decoding strategy to .iso8601
                decoder.dateDecodingStrategy = .iso8601
                
                // Use this decoder to decode the JSON data into an array of Course instances
                let courses = try decoder.decode([Course].self, from: data)
                DispatchQueue.main.async {
                    completion(courses)
                }
            } catch {
                print("Failed to decode courses: \(error.localizedDescription)")
                completion([])
            }
        }
        
        task.resume()
    }
    
    func fetchAssignments(forCourseId courseId: Int, completion: @escaping ([Assignment]) -> Void) {
        guard let url = URL(string: "\(baseURL)courses/\(courseId)/assignments?access_token=\(accessToken)") else {
            print("Invalid URL for assignments")
            completion([])
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error fetching assignments: \(error?.localizedDescription ?? "Unknown error")")
                completion([])
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let assignments = try decoder.decode([Assignment].self, from: data)
                DispatchQueue.main.async {
                    completion(assignments)
                }
            } catch let DecodingError.dataCorrupted(context) {
                print("Data corrupted: \(context.debugDescription)")
                completion([])
            } catch let DecodingError.keyNotFound(key, context) {
                print("Key '\(key)' not found: \(context.debugDescription), path: \(context.codingPath)")
                completion([])
            } catch let DecodingError.valueNotFound(value, context) {
                print("Value '\(value)' not found: \(context.debugDescription), path: \(context.codingPath)")
                completion([])
            } catch let DecodingError.typeMismatch(type, context) {
                print("Type '\(type)' mismatch: \(context.debugDescription), path: \(context.codingPath)")
                completion([])
            } catch {
                print("Failed to decode assignments: \(error.localizedDescription)")
                completion([])
            }
        }
        
        task.resume()
    }

}



