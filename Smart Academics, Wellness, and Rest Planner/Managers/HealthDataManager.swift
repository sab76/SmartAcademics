import HealthKit
import Foundation

class HealthDataManager {
    let healthStore = HKHealthStore()
    
    func requestAuthorization(completion: @escaping (Bool, Error?) -> Void) {
        print("Requesting HealthKit authorization...")
        
        guard HKHealthStore.isHealthDataAvailable() else {
            print("HealthKit is not available on this device.")
            completion(false, nil)
            return
        }
        
        // Define the data types you want to read from HealthKit.
        guard let stepsType = HKQuantityType.quantityType(forIdentifier: .stepCount),
              let sleepType = HKCategoryType.categoryType(forIdentifier: .sleepAnalysis),
              let exerciseTimeType = HKQuantityType.quantityType(forIdentifier: .appleExerciseTime) else {
            print("One or more HealthKit types could not be created.")
            completion(false, nil)
            return
        }
        
        let workoutsType = HKObjectType.workoutType()
        
        // Request authorization to read the specified data types.
        let readTypes: Set<HKObjectType> = [stepsType, sleepType, workoutsType, exerciseTimeType]
        print("HealthKit types for authorization: \(readTypes)")
        
        healthStore.requestAuthorization(toShare: [], read: readTypes) { success, error in
            if let error = error {
                print("Authorization request error: \(error.localizedDescription)")
            }
            print("Authorization success: \(success)")
            completion(success, error)
        }
        let status = healthStore.authorizationStatus(for: exerciseTimeType)

        switch status {
        case .notDetermined:
            print("Authorization not determined for steps.")
        case .sharingAuthorized:
            print("Authorization granted for steps.")
        case .sharingDenied:
            print("Authorization denied for steps.")
        @unknown default:
            print("Unknown authorization status for steps.")
        }
    }
    // In HealthDataManager
    
    // Fetch Exercise Minutes
    func fetchExerciseMinutes(completion: @escaping (Int) -> Void) {
        guard let exerciseTimeType = HKQuantityType.quantityType(forIdentifier: .appleExerciseTime) else {
            print("Exercise Time Type is not available.")
            completion(0)
            return
        }

        // Calculate the start date as 7 days ago from now
        let endDate = Date() // Current time
        let startDate = Calendar.current.date(byAdding: .day, value: -7, to: endDate)!

        // Create a predicate to fetch samples from the last 7 days
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)

        // Since appleExerciseTime is a cumulative metric, we use HKStatisticsQuery
        let query = HKStatisticsQuery(quantityType: exerciseTimeType, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, result, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Error fetching exercise minutes: \(error.localizedDescription)")
                    completion(0)
                    return
                }
                guard let sum = result?.sumQuantity() else {
                    completion(0)
                    return
                }
                // Convert the total time from seconds to minutes
                let totalMinutes = Int(sum.doubleValue(for: HKUnit.minute()))
                completion(totalMinutes)
            }
        }

        self.healthStore.execute(query)
    }


    // Fetch Sleep Hours
    func fetchSleepHours(completion: @escaping (Double) -> Void) {
        guard let sleepType = HKObjectType.categoryType(forIdentifier: .sleepAnalysis) else {
            completion(0)
            return
        }
        
        let now = Date()
        let predicate = HKQuery.predicateForSamples(withStart: Calendar.current.date(byAdding: .hour, value: -100, to: now)!, end: now, options: .strictStartDate)
        
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: true)
        
        let query = HKSampleQuery(sampleType: sleepType, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: [sortDescriptor]) { _, results, error in
            if let error = error {
                print("Error fetching sleep hours: \(error.localizedDescription)")
                completion(0)
                return
            }
            
            let totalHours = results?.reduce(0.0) { (acc, sample) -> Double in
                guard let sleepAnalysis = sample as? HKCategorySample else { return acc }
                
                if sleepAnalysis.value == HKCategoryValueSleepAnalysis.asleepUnspecified.rawValue ||
                   sleepAnalysis.value == HKCategoryValueSleepAnalysis.asleepDeep.rawValue ||
                   sleepAnalysis.value == HKCategoryValueSleepAnalysis.asleepREM.rawValue {
                    return acc + sleepAnalysis.endDate.timeIntervalSince(sleepAnalysis.startDate) / 3600.0
                }
                
                return acc
            } ?? 0.0
            
            DispatchQueue.main.async {
                completion(totalHours)
            }
        }
        
        healthStore.execute(query)
    }

    
    // Existing methods for fetching step count and sleep analysis...
    func fetchWorkouts(completion: @escaping ([WorkoutData]) -> Void) {
        // Pass nil as the predicate to fetch workouts of all types
        let workoutPredicate: NSPredicate? = nil // No specific filtering
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)
        let query = HKSampleQuery(sampleType: HKObjectType.workoutType(), predicate: workoutPredicate, limit: HKObjectQueryNoLimit, sortDescriptors: [sortDescriptor]) { (query, samples, error) in
            DispatchQueue.main.async {
                if let error = error {
                    print("Error fetching workouts: \(error.localizedDescription)")
                    return
                }
                guard let workouts = samples as? [HKWorkout], error == nil else {
                    completion([])
                    return
                }
                let workoutData = workouts.map { WorkoutData(workout: $0) }
                completion(workoutData)
            }
        }
        self.healthStore.execute(query)
    }
    
    
    func fetchStepCount(completion: @escaping (Int) -> Void) {
        guard let stepCountType = HKQuantityType.quantityType(forIdentifier: .stepCount) else {
            completion(0)
            return
        }

        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)

        let query = HKStatisticsQuery(quantityType: stepCountType, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, result, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Error fetching step count: \(error.localizedDescription)")
                    return
                }
                guard let sum = result?.sumQuantity() else {
                    completion(0)
                    return
                }
                let steps = Int(sum.doubleValue(for: HKUnit.count()))
                completion(steps)
            }
        }
        healthStore.execute(query)
    }
}
