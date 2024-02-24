//
//  CanvasAPIManager.swift
//  Smart Academics, Wellness, and Rest Planner
//
//  Created by Haley Marts on 2/23/24.
//To connect to the Canvas API and fetch academic information, we will need to use network requests.
//Down below the code: is a simplified example to get us started. We will need to replace "YOUR_ACCESS_TOKEN" with an actual access token and adjust the URL and parameters according to our needs.

import Foundation

class CanvasAPIManager {
    static let shared = CanvasAPIManager()
    private init() {}

    func fetchCourses(completion: @escaping ([Course]) -> Void) {
        guard let url = URL(string: "https://canvas.instructure.com/api/v1/courses?access_token=4407~MB2iekGh84K7fxQKH2OoGeXGUnbBuChKTnpIK4uyL1U4J1vxge6Ym0Ftakt4fkwz") else {
            print("Invalid URL")
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error fetching courses: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            do {
                let courses = try JSONDecoder().decode([Course].self, from: data)
                DispatchQueue.main.async {
                    completion(courses)
                }
            } catch {
                print("Failed to decode courses: \(error.localizedDescription)")
            }
        }

        task.resume()
    }
    func fetchAssignments(forCourseId courseId: Int, userId: String, completion: @escaping ([Assignment]) -> Void) {
        let accessToken = "4407~MB2iekGh84K7fxQKH2OoGeXGUnbBuChKTnpIK4uyL1U4J1vxge6Ym0Ftakt4fkwz"
        let urlString = "https://canvas.instructure.com/api/v1/users/\(userId)/courses/\(courseId)/assignments?access_token=\(accessToken)"
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }

        _ = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error fetching assignments: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            // Print the raw JSON for debugging
            let jsonString = String(data: data, encoding: .utf8)
            print("JSON String: \(jsonString ?? "N/A")")

            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let assignments = try decoder.decode([Assignment].self, from: data)
                DispatchQueue.main.async {
                    completion(assignments)
                }
            } catch {
                print("Failed to decode assignments: \(error.localizedDescription)")
            }
        }

    }
    func fetchCurrentUserCourses(completion: @escaping ([Course]) -> Void) {
        let accessToken = "4407~MB2iekGh84K7fxQKH2OoGeXGUnbBuChKTnpIK4uyL1U4J1vxge6Ym0Ftakt4fkwz"
        let urlString = "https://canvas.instructure.com/api/v1/courses?access_token=\(accessToken)&enrollment_state=active"
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error fetching courses: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601 // Adjust this based on the actual date format returned by Canvas
                let courses = try decoder.decode([Course].self, from: data)
                DispatchQueue.main.async {
                    completion(courses)
                }
            } catch {
                print("Failed to decode courses: \(error.localizedDescription)")
            }
        }

        task.resume()
    }

}

struct Course: Codable, Identifiable {
    let id: Int
    let name: String
    // Add more properties as needed
}

