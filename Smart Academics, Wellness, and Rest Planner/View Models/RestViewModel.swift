import Foundation
import HealthKit
import Combine

class RestViewModel: ObservableObject {
    @Published var data: [SleepData] = []
    @Published var aggregatedData: [AggregatedSleepData] = [] // This will hold the aggregated sleep data
    private var healthDataManager: HealthDataManager
    
    init(healthDataManager: HealthDataManager) {
        self.healthDataManager = healthDataManager
        requestAuthorizationAndFetchData()
    }
    
    func requestAuthorizationAndFetchData() {
        healthDataManager.requestAuthorization { [weak self] success, _ in
            if success {
                self?.fetchRestData()
            }
        }
    }

    func fetchRestData() {
        guard let sleepType = HKObjectType.categoryType(forIdentifier: .sleepAnalysis) else {
            return
        }
        
        let now = Date()
        let startOfPreviousDay = Calendar.current.startOfDay(for: now).addingTimeInterval(-24 * 60 * 60)
        let predicate = HKQuery.predicateForSamples(withStart: startOfPreviousDay, end: now, options: .strictStartDate)
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)
        
        let query = HKSampleQuery(sampleType: sleepType, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: [sortDescriptor]) { [weak self] (query, results, error) in
            guard let self = self, let sleepResults = results as? [HKCategorySample], error == nil else {
                print("Failed to fetch sleep data: \(String(describing: error))")
                return
            }
            
            let newData = sleepResults.map { sample -> SleepData in
                let hoursSlept = sample.endDate.timeIntervalSince(sample.startDate) / 3600 // Convert seconds to hours
                let sleepState = HKCategoryValueSleepAnalysis(rawValue: sample.value) ?? .inBed // Handle the optional with a default value
                return SleepData(date: sample.startDate, hoursSlept: hoursSlept, sleepState: sleepState)
            }
            
            // Call aggregateData to process and store the fetched data
            self.aggregateData(sleepData: newData)
        }
        
        healthDataManager.healthStore.execute(query)
    }
    private func updateAggregatedData() {
            self.aggregatedData = aggregateData(sleepData: self.data)
        }
    
    private func aggregateData(sleepData: [SleepData]) -> [AggregatedSleepData] {
        let groupedData = Dictionary(grouping: sleepData) { (element: SleepData) in
            return Calendar.current.startOfDay(for: element.date)
        }
        
        return groupedData.map { (key, value) in
            AggregatedSleepData(
                date: key,
                totalHoursSlept: value.reduce(0) { $0 + $1.hoursSlept },
                predominantSleepState: predominantState(from: value)
            )
        }.sorted(by: { $0.date > $1.date })
    }

    
    private func predominantState(from sleepData: [SleepData]) -> HKCategoryValueSleepAnalysis {
        let sleepStateCounts = sleepData.reduce(into: [:]) { counts, data in
            counts[data.sleepState, default: 0] += 1
        }
        return sleepStateCounts.max(by: { $0.value < $1.value })?.key ?? .inBed
    }
}

struct AggregatedSleepData: Identifiable {
    var id = UUID()
    var date: Date
    var totalHoursSlept: Double
    var predominantSleepState: HKCategoryValueSleepAnalysis
}

