//
//  Assignment.swift
//  Smart Academics, Wellness, and Rest Planner
//
//  Created by Haley Marts on 2/23/24.
//

import Foundation

struct Assignment: Codable, Identifiable {
    let id: Int
    let name: String
    let dueAt: Date?
    
    private enum CodingKeys: String, CodingKey {
        case id, name
        case dueAt = "due_at"
    }
}

