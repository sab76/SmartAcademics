//
//  FitnessData.swift
//  Smart Academics, Wellness, and Rest Planner

import Foundation
import HealthKit

struct FitnessData: Identifiable {
    var id = UUID()
    var date: Date
    var steps: Int
    var workoutMinutes: Int
    var sleepHours: Int
    var sleepQuality: String
    var activityRecommendation: String?
    var studyLocationRecommendation: String?
    // Add new fields for heart rate and workouts
    var averageHeartRate: Int
    var workouts: [WorkoutData]
}



