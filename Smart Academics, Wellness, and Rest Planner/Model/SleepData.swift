//
//  SleepData.swift
//  Smart Academics, Wellness, and Rest Planner


import Foundation
import HealthKit

struct SleepData: Identifiable {
    var id: UUID = UUID()  // unique identifier for each sleep data entry
    var date: Date
    var hoursSlept: Double
    var sleepState: HKCategoryValueSleepAnalysis
    
}
