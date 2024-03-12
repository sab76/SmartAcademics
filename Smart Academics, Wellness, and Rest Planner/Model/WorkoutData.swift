//
//  WorkoutData.swift
//  Smart Academics, Wellness, and Rest Planner
//
//  Created by Haley Marts on 3/11/24.
//

import Foundation
import HealthKit

// New WorkoutData model
struct WorkoutData: Identifiable {
    var id = UUID()
    var workoutType: HKWorkoutActivityType
    var duration: TimeInterval
    var caloriesBurned: Double
    var distance: Double
    
    init(workout: HKWorkout) {
        self.workoutType = workout.workoutActivityType
        self.duration = workout.duration
        self.caloriesBurned = workout.totalEnergyBurned?.doubleValue(for: .kilocalorie()) ?? 0
        self.distance = workout.totalDistance?.doubleValue(for: .meterUnit(with: .kilo)) ?? 0
    }
}
