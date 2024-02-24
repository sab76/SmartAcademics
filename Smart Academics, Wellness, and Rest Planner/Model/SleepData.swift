//
//  SleepData.swift
//  Smart Academics, Wellness, and Rest Planner
//
//  Created by Haley Marts on 2/23/24.
//

import Foundation

struct SleepData: Identifiable {
    var id: UUID = UUID()  // Provides a unique identifier for each sleep data entry
    var date: Date  // Represents the date of the sleep analysis
    var hoursSlept: Double  // Represents the number of hours slept
    // Add any other relevant properties you need for sleep analysis
}

