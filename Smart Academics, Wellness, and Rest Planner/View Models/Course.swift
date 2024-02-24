//
//  Course.swift
//  Smart Academics, Wellness, and Rest Planner


import Foundation

struct Course: Identifiable, Codable {
    let id: Int
    let name: String
    var assignments: [Assignment]

    // will add any other properties and initializers as needed
}

