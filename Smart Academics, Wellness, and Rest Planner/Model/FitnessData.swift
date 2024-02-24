//
//  FitnessData.swift
//  Smart Academics, Wellness, and Rest Planner
//
//  Created by Haley Marts on 2/23/24.
//

import Foundation

struct FitnessData: Identifiable {
    var id = UUID()
    var date: Date
    var steps: Int
    var workoutMinutes: Int
}

