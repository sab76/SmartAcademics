import Foundation
import HealthKit
import Combine

class RestViewModel: ObservableObject {
    @Published var data: [SleepData] = []
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
        
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)
        let query = HKSampleQuery(sampleType: sleepType, predicate: nil, limit: HKObjectQueryNoLimit, sortDescriptors: [sortDescriptor]) { [weak self] (query, results, error) in
            
            guard let self = self, let sleepResults = results as? [HKCategorySample], error == nil else {
                print("Failed to fetch sleep data: \(String(describing: error))")
                return
            }
            
            let newData = sleepResults.map { sample -> SleepData in
                let hoursSlept = sample.endDate.timeIntervalSince(sample.startDate) / 3600 // Convert seconds to hours
                let sleepState = HKCategoryValueSleepAnalysis(rawValue: sample.value) ?? .inBed // Handle the optional with a default value

                return SleepData(date: sample.startDate, hoursSlept: hoursSlept, sleepState: sleepState)
            }
            
            DispatchQueue.main.async {
                self.data = newData
            }
        }
        
        healthDataManager.healthStore.execute(query)
    }

}
