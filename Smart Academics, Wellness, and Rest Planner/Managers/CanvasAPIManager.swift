import Foundation
/*
class CanvasAPIManager {
    static let shared = CanvasAPIManager()
    private init() {}
    
    func fetchCourseIDs(completion: @escaping ([Int]) -> Void) {
        guard let url = URL(string: "https://canvas.instructure.com/api/v1/courses?access_token=4407~R65Obhgz7wDpUmlMuONho4bsKz11YccD5gwNwePxZyaPXdN1uG1SU3zSdeuy2k0v") else {
            print("Invalid URL")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error fetching courses: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            // 1. Inspect JSON Response
            if let jsonString = String(data: data, encoding: .utf8) {
                print("Raw JSON Response: \(jsonString)")
            }
            
            // 2. Handle Empty Responses
            guard !data.isEmpty else {
                print("Empty response received from the API.")
                completion([]) // Return an empty array if response is empty
                return
            }
            
            do {
                let courses = try JSONDecoder().decode([Course].self, from: data)
                let courseIDs = courses.map { $0.id } // Extract the IDs from the courses
                DispatchQueue.main.async {
                    completion(courseIDs) // Return just the IDs
                }
            } catch {
                // 3. Error Handling
                print("Failed to decode courses: \(error.localizedDescription)")
            }
        }
        
        task.resume()
    }
    
    func fetchAssignments(forCourseId courseId: Int, userId: String, completion: @escaping ([Assignment]) -> Void) {
        let accessToken = "4407~R65Obhgz7wDpUmlMuONho4bsKz11YccD5gwNwePxZyaPXdN1uG1SU3zSdeuy2k0v"
        guard let url = URL(string: "https://canvas.instructure.com/api/v1/users/\(userId)/courses/\(courseId)/assignments?access_token=\(accessToken)") else {
            print("Invalid URL")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error fetching assignments: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            // 1. Inspect JSON Response
            if let jsonString = String(data: data, encoding: .utf8) {
                print("Raw JSON String: \(jsonString)")
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let assignments = try decoder.decode([Assignment].self, from: data)
                DispatchQueue.main.async {
                    completion(assignments)
                }
            } catch {
                // 3. Error Handling
                print("Failed to decode assignments: \(error.localizedDescription)")
            }
        }
        
        task.resume() // This line is crucial for starting the network request
    }
    
    func fetchCurrentUserCourses(completion: @escaping ([Course]) -> Void) {
        let accessToken = "4407~R65Obhgz7wDpUmlMuONho4bsKz11YccD5gwNwePxZyaPXdN1uG1SU3zSdeuy2k0v"
        guard let url = URL(string: "https://canvas.instructure.com/api/v1/courses?access_token=\(accessToken)&enrollment_state=active") else {
            print("Invalid URL")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error fetching courses: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            // 1. Inspect JSON Response
            if let jsonString = String(data: data, encoding: .utf8) {
                print("Raw JSON Response: \(jsonString)")
            }
            
            // 2. Handle Empty Responses
            guard !data.isEmpty else {
                print("Empty response received from the API.")
                completion([]) // Return an empty array if response is empty
                return
            }
            print("Raw JSON Response: \(String(data: data, encoding: .utf8) ?? "Unable to decode data")")
            
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601 // Will adjust this based on the actual date format returned by Canvas
                let courses = try decoder.decode([Course].self, from: data)
                DispatchQueue.main.async {
                    completion(courses)
                }
            } catch {
                // 3. Error Handling
                print("Failed to decode courses: \(error.localizedDescription)")
            }
        }
        
        task.resume()
    }
   
}
*/

