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
            
            // If authorization is successful, proceed to fetch fitness and activity data
            self?.fetchFitnessAndActivityData()
        }
    }
    
    func fetchFitnessAndActivityData() {
        let dispatchGroup = DispatchGroup()

        var stepCount = 0
        var exerciseMinutes = 0 // Replacing workoutMinutes with exerciseMinutes
        var sleepHours = 0.0
        let sleepQuality = "Good" // Placeholder for sleep quality

        dispatchGroup.enter()
        healthDataManager.fetchStepCount { fetchedSteps in
            stepCount = fetchedSteps
            dispatchGroup.leave()
        }

        dispatchGroup.enter()
        healthDataManager.fetchExerciseMinutes { fetchedExerciseMinutes in
            exerciseMinutes = fetchedExerciseMinutes
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
            let fitnessData = FitnessData(date: today, steps: stepCount, activityMinutes: Int(exerciseMinutes), sleepHours: Int(sleepHours), sleepQuality: sleepQuality, activityRecommendation: nil, studyLocationRecommendation: nil)
            // Update your observed data array, this example simply sets it with the new data
            self.data = [fitnessData]
            //debugging
            dispatchGroup.notify(queue: .main) {
                print("Fetched Data - Steps: \(stepCount), Activity Minutes: \(exerciseMinutes), Sleep Hours: \(sleepHours)")
            }
        }
    }
}
