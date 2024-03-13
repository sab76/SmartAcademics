import HealthKit
import Foundation

class HealthDataManager {
    let healthStore = HKHealthStore()
    
    func requestAuthorization(completion: @escaping (Bool, Error?) -> Void) {
        guard HKHealthStore.isHealthDataAvailable() else {
            completion(false, nil)
            return
        }
        
        // Define the data types you want to read from HealthKit.
        guard let stepsType = HKQuantityType.quantityType(forIdentifier: .stepCount),
              let sleepType = HKCategoryType.categoryType(forIdentifier: .sleepAnalysis),
              let heartRateType = HKQuantityType.quantityType(forIdentifier: .heartRate) else {
            completion(false, nil)
            return
        }
        
        // WorkoutsType does not need to be unwrapped
        let workoutsType = HKObjectType.workoutType()
        
        // Request authorization to read the specified data types.
        let readTypes: Set<HKObjectType> = [stepsType, sleepType, heartRateType, workoutsType]
        
        healthStore.requestAuthorization(toShare: [], read: readTypes) { success, error in
            completion(success, error)
        }
    }
    // In HealthDataManager

    // Fetch Workout Minutes
    func fetchWorkoutMinutes(completion: @escaping (Int) -> Void) {
        let workoutType = HKObjectType.workoutType()
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)
        
        let query = HKSampleQuery(sampleType: workoutType, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { _, results, _ in
            let totalMinutes = results?.reduce(0) { (acc, sample) -> Int in
                let workout = sample as! HKWorkout
                return acc + Int(workout.duration / 60)
            } ?? 0
            DispatchQueue.main.async {
                completion(totalMinutes)
            }
        }
        
        self.healthStore.execute(query)
    }

    // Fetch Sleep Hours
    func fetchSleepHours(completion: @escaping (Double) -> Void) {
        guard let sleepType = HKObjectType.categoryType(forIdentifier: .sleepAnalysis) else {
            return
        }
        
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)
        
        let query = HKSampleQuery(sampleType: sleepType, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { _, results, _ in
            let totalHours = results?.reduce(0.0) { (acc, sample) -> Double in
                let sleepAnalysis = sample as! HKCategorySample
                return acc + sleepAnalysis.endDate.timeIntervalSince(sleepAnalysis.startDate) / 3600.0
            } ?? 0.0
            DispatchQueue.main.async {
                completion(totalHours)
            }
        }
        
        self.healthStore.execute(query)
    }

    // Existing methods for fetching step count and sleep analysis...
    func fetchWorkouts(completion: @escaping ([WorkoutData]) -> Void) {
        // Pass nil as the predicate to fetch workouts of all types
        let workoutPredicate: NSPredicate? = nil // No specific filtering
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)
        let query = HKSampleQuery(sampleType: HKObjectType.workoutType(), predicate: workoutPredicate, limit: HKObjectQueryNoLimit, sortDescriptors: [sortDescriptor]) { (query, samples, error) in
            DispatchQueue.main.async {
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

    
    // Method to fetch heart rate data
    func fetchHeartRateData(forDate date: Date, completion: @escaping ([HeartRateData]) -> Void) {
        guard let heartRateType = HKQuantityType.quantityType(forIdentifier: .heartRate) else {
            completion([])
            return
        }
        let startOfDay = Calendar.current.startOfDay(for: date)
        let endOfDay = Calendar.current.date(byAdding: .day, value: 1, to: startOfDay)!
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: endOfDay, options: .strictStartDate)
        let query = HKSampleQuery(sampleType: heartRateType, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: [NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)]) { (query, samples, error) in
            DispatchQueue.main.async {
                guard let samples = samples as? [HKQuantitySample], error == nil else {
                    completion([])
                    return
                }
                let heartRateData = samples.map { HeartRateData(sample: $0) }
                completion(heartRateData)
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

        let query = HKStatisticsQuery(quantityType: stepCountType, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, result, _ in
            DispatchQueue.main.async {
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



