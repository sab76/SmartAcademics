//
//  RestData.swift
//  Smart Academics, Wellness, and Rest Planner
//


import Foundation
import HealthKit

struct RestData: Identifiable {
    var id = UUID()
    var date: Date
    var hoursSlept: Double
}

struct RestPreferences {
    var sleepGoalHours: Double
    var quietHoursStart: Date
    var quietHoursEnd: Date
}

struct AggregatedRestData {
    var date: Date
    var totalHoursSlept: Double
}

