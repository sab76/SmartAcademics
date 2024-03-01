//
//  MockDataFetcher.swift
//  Smart Academics, Wellness, and Rest Planner
//
//  Created by Haley Marts on 2/24/24.
import Foundation
import SwiftUI

class MockDataFetcher: AcademicDataFetching {
    private let formatter = ISO8601DateFormatter()

    // Assignments defined at the class level for accessibility in both methods
    private lazy var assignmentsFor125: [Assignment] = [
        Assignment(
            id: 1,
            name: "First Assignment",
            description: "Introduction to Search Systems",
            createdAt: Date(),
            updatedAt: Date(),
            dueAt: formatter.date(from: "2024-03-10T23:59:00Z"),
            lockAt: nil,
            unlockAt: nil,
            courseId: 125,
            htmlUrl: "https://example.com/assignment1",
            submissionsDownloadUrl: "https://example.com/assignment1/submissions",
            assignmentGroupId: 1
        )
    ]

    private lazy var assignmentsFor171: [Assignment] = [
        Assignment(
            id: 2,
            name: "AI Basics",
            description: "Introduction to Artificial Intelligence concepts",
            createdAt: Date(),
            updatedAt: Date(),
            dueAt: formatter.date(from: "2024-04-15T23:59:00Z"),
            lockAt: nil,
            unlockAt: nil,
            courseId: 171,
            htmlUrl: "https://example.com/comp171/assignment1",
            submissionsDownloadUrl: "https://example.com/comp171/assignment1/submissions",
            assignmentGroupId: 2
        ),
        Assignment(
            id: 5,
            name: "Machine Learning Primer",
            description: "Overview of machine learning techniques and applications.",
            createdAt: Date(),
            updatedAt: Date(),
            dueAt: formatter.date(from: "2024-05-10T23:59:00Z"),
            lockAt: nil,
            unlockAt: nil,
            courseId: 171,
            htmlUrl: "https://example.com/comp171/assignment2",
            submissionsDownloadUrl: "https://example.com/comp171/assignment2/submissions",
            assignmentGroupId: 2
        )
    ]

    private lazy var assignmentsFor116: [Assignment] = [
        Assignment(
            id: 3,
            name: "Computational Photography Overview",
            description: "Introduces the problems of computer vision through the application of computational photography.",
            createdAt: Date(),
            updatedAt: Date(),
            dueAt: formatter.date(from: "2024-04-15T23:59:00Z"),
            lockAt: nil,
            unlockAt: nil,
            courseId: 116,
            htmlUrl: "https://example.com/comp116/assignment1",
            submissionsDownloadUrl: "https://example.com/comp116/assignment1/submissions",
            assignmentGroupId: 3
        ),
        Assignment(
            id: 6,
            name: "HDR Imaging",
            description: "Creating high dynamic range (HDR) images through computational methods.",
            createdAt: Date(),
            updatedAt: Date(),
            dueAt: formatter.date(from: "2024-06-01T23:59:00Z"),
            lockAt: nil,
            unlockAt: nil,
            courseId: 116,
            htmlUrl: "https://example.com/comp116/assignment2",
            submissionsDownloadUrl: "https://example.com/comp116/assignment2/submissions",
            assignmentGroupId: 3
        )
    ]

    private lazy var assignmentsFor161: [Assignment] = [
        Assignment(
            id: 4,
            name: "Algorithm Design Techniques",
            description: "Techniques for efficient algorithm design, including divide-and-conquer and dynamic programming, and time/space analysis.",
            createdAt: Date(),
            updatedAt: Date(),
            dueAt: formatter.date(from: "2024-04-15T23:59:00Z"),
            lockAt: nil,
            unlockAt: nil,
            courseId: 161,
            htmlUrl: "https://example.com/comp161/assignment1",
            submissionsDownloadUrl: "https://example.com/comp161/assignment1/submissions",
            assignmentGroupId: 4
        ),
        Assignment(
            id: 7,
            name: "Graph Algorithms",
            description: "Exploration of algorithms for graph traversal, shortest paths, and network flows.",
            createdAt: Date(),
            updatedAt: Date(),
            dueAt: formatter.date(from: "2024-07-20T23:59:00Z"),
            lockAt: nil,
            unlockAt: nil,
            courseId: 161,
            htmlUrl: "https://example.com/comp161/assignment2",
            submissionsDownloadUrl: "https://example.com/comp161/assignment2/submissions",
            assignmentGroupId: 4
        )
    ]


    func fetchCourses(completion: @escaping ([Course]) -> Void) {
        // Now accessible here
        let courses = [
            Course(id: 125, name: "CompSci 125: Next Generation Search Systems", assignments: assignmentsFor125, priority: .high),
            Course(id: 171, name: "CompSci 171: Introduction to Artificial Intelligence", assignments: assignmentsFor171, priority: .high),
            Course(id: 116, name: "CompSci 116: Computational Photography and Vision", assignments: assignmentsFor116, priority: .high), // Corrected course name
            Course(id: 161, name: "CompSci 161: Design and Analysis of Algorithms", assignments: assignmentsFor161, priority: .high), // Corrected course name
        ]

        completion(courses)
    }

    func fetchAssignments(forCourseId courseId: Int, completion: @escaping ([Assignment]) -> Void) {
        switch courseId {
        case 125:
            completion(assignmentsFor125)
        case 171:
            completion(assignmentsFor171)
        case 116:
            completion(assignmentsFor116)
        case 161:
            completion(assignmentsFor161)
        default:
            completion([]) // No assignments for unrecognized courseIds
        }
    }
}


