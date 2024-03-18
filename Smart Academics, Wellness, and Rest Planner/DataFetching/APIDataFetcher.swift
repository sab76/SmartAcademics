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
    let accessToken = ""
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
                var assignments = try decoder.decode([Assignment].self, from: data)

                if courseId == 61901 {
                    let specificAssignmentURL = URL(string: "\(self.baseURL)courses/\(courseId)/assignments/1339752?access_token=\(self.accessToken)")!
                    let specificAssignmentTask = URLSession.shared.dataTask(with: specificAssignmentURL) { specificData, specificResponse, specificError in
                        guard let specificData = specificData, specificError == nil else {
                            print("Error fetching the specific assignment: \(specificError?.localizedDescription ?? "Unknown error")")
                            DispatchQueue.main.async {
                                completion(assignments) // Complete with the assignments already fetched
                            }
                            return
                        }
                        
                        do {
                            let specificAssignment = try decoder.decode(Assignment.self, from: specificData)
                            assignments.append(specificAssignment) // Add the specific assignment to the assignments array
                            DispatchQueue.main.async {
                                completion(assignments)
                            }
                        } catch {
                            print("Failed to decode the specific assignment: \(error.localizedDescription)")
                            DispatchQueue.main.async {
                                completion(assignments) // Complete with the assignments already fetched
                            }
                        }
                    }
                    specificAssignmentTask.resume()
                } else {
                    DispatchQueue.main.async {
                        completion(assignments) // If not the specific course, complete with the fetched assignments
                    }
                }
            } catch {
                print("Failed to decode assignments: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    completion([])
                }
            }
        }
        
        task.resume()
    }

}



