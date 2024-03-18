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




