//
//  FitnessData.swift
//  Smart Academics, Wellness, and Rest Planner

import Foundation
import HealthKit

struct FitnessData: Identifiable {
    var id = UUID()
    var date: Date
    var steps: Int
    var activityMinutes: Int
    var sleepHours: Int
    var sleepQuality: String
    var activityRecommendation: String?
    var studyLocationRecommendation: String?
}
/*
let fitnessData = FitnessData(
    date: today,
    steps: stepCount,
    activityMinutes: exerciseMinutes, // Ensure this matches the new parameter name
    sleepHours: Int(sleepHours),
    sleepQuality: sleepQuality,
    // Remove any parameters no longer expected
    // Add any new parameters that are now expected
)*/



