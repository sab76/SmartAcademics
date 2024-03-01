//
//  FitnessGoal.swift
//  Smart Academics, Wellness, and Rest Planner
//

import Foundation
import SwiftUI

struct FitnessGoal: Codable {
    var workoutFrequency: Int // Weekly frequency
    var workoutType: String // Type of workout
    var workoutDuration: Int // Min per session
}

