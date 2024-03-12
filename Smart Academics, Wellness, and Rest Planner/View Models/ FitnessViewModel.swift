import Foundation
import Combine

class FitnessViewModel: ObservableObject {
    @Published var data: [FitnessData] = []
    @Published var showWellnessInsights: Bool = false
    @Published var wellnessInsights: String = ""
    
    private var healthDataManager: HealthDataManager
    
    init(healthDataManager: HealthDataManager) {
        self.healthDataManager = healthDataManager
        requestAuthorizationAndFetchData()
    }
    
    private func requestAuthorizationAndFetchData() {
        healthDataManager.requestAuthorization { [weak self] success, error in
            guard success else {
                // Handle the error or denied authorization as needed
                return
            }
            
            // If authorization is successful, proceed to fetch fitness data
            self?.fetchFitnessData()
        }
    }
    
    func fetchFitnessData() {
        // Fetch step count from HealthDataManager
        healthDataManager.fetchStepCount { [weak self] stepCount in
            DispatchQueue.main.async {
                // Assuming you need to fetch additional data (e.g., averageHeartRate, workouts)
                // For demonstration, these are set with dummy data. Replace with actual fetch calls.
                let averageHeartRate = 0 // Replace with actual fetch call and logic
                var workouts: [WorkoutData] = [] // Replace with actual fetch call and logic

                // Now, create the FitnessData with all required parameters
                let today = Date()
                let fitnessData = FitnessData(date: today, steps: stepCount, workoutMinutes: 0, sleepHours: 0, sleepQuality: "", activityRecommendation: nil, studyLocationRecommendation: nil, averageHeartRate: averageHeartRate, workouts: workouts)
                
                // Update your observed data array
                self?.data = [fitnessData]
            }
        }
    }

}



