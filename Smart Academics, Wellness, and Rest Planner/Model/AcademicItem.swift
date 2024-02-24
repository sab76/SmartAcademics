//
//  AcademicItem.swift
//  Smart Academics, Wellness, and Rest Planner
//
//  Created by Haley Marts on 2/23/24.
//

import Foundation

struct AcademicItem: Identifiable {
    var id: UUID = UUID()
    var title: String
    var deadline: Date
    var description: String
}

