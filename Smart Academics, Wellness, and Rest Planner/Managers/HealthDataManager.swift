//
//  HealthDataManager.swift
//  Smart Academics, Wellness, and Rest Planner
//
//  Created by Haley Marts on 2/23/24.
// Make sure we have the necessary permissions to set up in our app's Info.plist and request authorization from the user. 

import HealthKit
import Foundation

class HealthDataManager {
    let healthStore = HKHealthStore()

    func requestAuthorization(completion: @escaping (Bool) -> Void) {
        guard HKHealthStore.isHealthDataAvailable() else {
            completion(false)
            return
        }

        guard let stepsType = HKQuantityType.quantityType(forIdentifier: .stepCount),
              let sleepType = HKCategoryType.categoryType(forIdentifier: .sleepAnalysis) else {
            completion(false)
            return
        }

        healthStore.requestAuthorization(toShare: [], read: [stepsType, sleepType]) { success, error in
            completion(success)
        }
    }

    // Example function to fetch step count
    func fetchStepCount(completion: @escaping (Int) -> Void) {
        // Implementation goes here
    }

    // Example function to fetch sleep analysis
    func fetchSleepAnalysis(completion: @escaping ([SleepData]) -> Void) {
        // Implementation goes here
    }
}

