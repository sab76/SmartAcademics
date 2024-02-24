//
//  FitnessData.swift
//  Smart Academics, Wellness, and Rest Planner

import Foundation

struct FitnessData: Identifiable {
    var id = UUID()
    var date: Date
    var steps: Int
    var workoutMinutes: Int
    // New properties
    var sleepHours: Int
    var sleepQuality: String
    var activityRecommendation: String?
    var studyLocationRecommendation: String?
}


