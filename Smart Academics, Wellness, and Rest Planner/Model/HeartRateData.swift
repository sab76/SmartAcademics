//
//  HeartRateData.swift
//  Smart Academics, Wellness, and Rest Planner
//
//  Created by Haley Marts on 3/11/24.
//

import Foundation
import HealthKit

// New HeartRateData model
struct HeartRateData: Identifiable {
    var id = UUID()
    var heartRate: Double
    var date: Date
    
    init(sample: HKQuantitySample) {
        self.heartRate = sample.quantity.doubleValue(for: .count().unitDivided(by: .minute()))
        self.date = sample.startDate
    }
}
