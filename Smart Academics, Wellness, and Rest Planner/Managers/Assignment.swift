//
//  Assignment.swift
//  Smart Academics, Wellness, and Rest Planner


import Foundation

struct Assignment: Codable, Identifiable {
    let id: Int
    let name: String
    let description: String?
    let createdAt: Date
    let updatedAt: Date
    let dueAt: Date?
    let lockAt: Date?
    let unlockAt: Date?
    let courseId: Int
    let htmlUrl: String
    let submissionsDownloadUrl: String
    let assignmentGroupId: Int

    private enum CodingKeys: String, CodingKey {
        case id, name, description, courseId, htmlUrl, submissionsDownloadUrl, assignmentGroupId
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case dueAt = "due_at"
        case lockAt = "lock_at"
        case unlockAt = "unlock_at"
    }
}
 

