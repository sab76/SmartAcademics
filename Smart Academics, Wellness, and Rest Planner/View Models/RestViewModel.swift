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
        let predicate = HKQuery.predicateForSamples(withStart: startOfPreviousDay, end: now, options: [.strictStartDate, .strictEndDate])
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: true)

        let query = HKSampleQuery(sampleType: sleepType, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: [sortDescriptor]) { [weak self] (_, results, error) in
            guard let self = self, error == nil else {
                print("Failed to fetch sleep data: \(String(describing: error))")
                return
            }
            
            let filteredResults = results as? [HKCategorySample] ?? []
            let sleepData = self.processSleepData(filteredResults)
            
            DispatchQueue.main.async {
                self.data = sleepData
                self.updateAggregatedData()
            }
        }
        
        healthDataManager.healthStore.execute(query)
    }

    private func processSleepData(_ sleepResults: [HKCategorySample]) -> [SleepData] {
        var sleepData: [SleepData] = []

        for sample in sleepResults {
            switch HKCategoryValueSleepAnalysis(rawValue: sample.value) {
            case .asleepDeep, .asleepCore, .asleepREM, .asleepUnspecified:
                let hoursSlept = sample.endDate.timeIntervalSince(sample.startDate) / 3600
                let data = SleepData(date: sample.startDate, hoursSlept: hoursSlept, sleepState: HKCategoryValueSleepAnalysis(rawValue: sample.value) ?? .inBed)
                sleepData.append(data)
            default:
                break // Skip in-bed or awake times if only calculating sleep time
            }
        }

        return sleepData
    }


    private func updateAggregatedData() {
            self.aggregatedData = aggregateData(sleepData: self.data)
        }
    
    private func aggregateData(sleepData: [SleepData]) -> [AggregatedSleepData] {
        let groupedData = Dictionary(grouping: sleepData) { (element: SleepData) in
            return Calendar.current.startOfDay(for: element.date)
        }
        
        return groupedData.map { (key, value) in
            let totalSleepTime = value.reduce(0) { $0 + $1.hoursSlept }
            let predominantSleepState = value.max(by: { a, b in a.hoursSlept < b.hoursSlept })?.sleepState ?? .inBed
            return AggregatedSleepData(date: key, totalHoursSlept: totalSleepTime, predominantSleepState: predominantSleepState)
        }
        .sorted(by: { $0.date > $1.date })
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
