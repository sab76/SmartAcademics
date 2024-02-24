//
//  AcademicItem.swift
//  Smart Academics, Wellness, and Rest Planner


import Foundation

struct AcademicItem: Identifiable {
    var id: UUID = UUID()
    var title: String
    var deadline: Date
    var description: String
}

