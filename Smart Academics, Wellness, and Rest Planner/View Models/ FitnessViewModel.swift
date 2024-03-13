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
        let dispatchGroup = DispatchGroup()

        var stepCount = 0
        var workoutMinutes = 0
        var sleepHours = 0.0
        // Placeholder for sleep quality, as HealthKit does not provide a direct metric.
        let sleepQuality = "Good"

        dispatchGroup.enter()
        healthDataManager.fetchStepCount { fetchedSteps in
            stepCount = fetchedSteps
            dispatchGroup.leave()
        }

        dispatchGroup.enter()
        healthDataManager.fetchWorkoutMinutes { fetchedWorkoutMinutes in
            workoutMinutes = fetchedWorkoutMinutes
            dispatchGroup.leave()
        }

        dispatchGroup.enter()
        healthDataManager.fetchSleepHours { fetchedSleepHours in
            sleepHours = fetchedSleepHours
            dispatchGroup.leave()
        }

        // When all async tasks are complete, update the UI
        dispatchGroup.notify(queue: .main) {
            let today = Date()
            let fitnessData = FitnessData(date: today, steps: stepCount, workoutMinutes: workoutMinutes, sleepHours: Int(sleepHours), sleepQuality: sleepQuality, activityRecommendation: nil, studyLocationRecommendation: nil, averageHeartRate: 0, workouts: [])
            // Update your observed data array, this example simply sets it with the new data
            self.data = [fitnessData]
            //debugging
            dispatchGroup.notify(queue: .main) {
                print("Fetched Data - Steps: \(stepCount), Workout Minutes: \(workoutMinutes), Sleep Hours: \(sleepHours)")
                
            }

        }
    }

}



