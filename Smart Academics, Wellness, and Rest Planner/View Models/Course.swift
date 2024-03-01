//
//  Course.swift
//  Smart Academics, Wellness, and Rest Planner


import Foundation

struct Course: Identifiable, Codable {
    let id: Int
    let name: String
    var assignments: [Assignment]
    var priority: Priority // Add the priority property here

    enum Priority: String, Codable, CaseIterable {
        case high = "High"
        case medium = "Medium"
        case low = "Low"
    }

    // will add any other properties and initializers as needed
}

