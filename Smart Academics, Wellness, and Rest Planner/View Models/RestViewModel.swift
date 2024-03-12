import Foundation
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
        // Fetch sleep analysis data
    }
}

/*previous code I will copy paste here so you can look at it
 import Foundation
 import Combine
 import SwiftUI

 class RestViewModel: ObservableObject {
     @Published var data: [RestData] = []
     @Published var restPreferences: RestPreferences?
     
     init() {
             fetchRestPreferences()
         }

     func fetchRestData() {
         // For now, we'll use mock data
         self.data = generateMockRestData()
     }
     // methods for rest preferences
         func fetchRestPreferences() {
             let defaults = UserDefaults.standard
             if let sleepGoalHours = defaults.value(forKey: "sleepGoalHours") as? Double,
                let quietHoursStart = defaults.value(forKey: "quietHoursStart") as? Date,
                let quietHoursEnd = defaults.value(forKey: "quietHoursEnd") as? Date {
                 restPreferences = RestPreferences(sleepGoalHours: sleepGoalHours, quietHoursStart: quietHoursStart, quietHoursEnd: quietHoursEnd)
             }
         }
     func saveRestPreferences(_ preferences: RestPreferences) {
             let defaults = UserDefaults.standard
             defaults.set(preferences.sleepGoalHours, forKey: "sleepGoalHours")
             defaults.set(preferences.quietHoursStart, forKey: "quietHoursStart")
             defaults.set(preferences.quietHoursEnd, forKey: "quietHoursEnd")
             // Update the local restPreferences property
             restPreferences = preferences
         }
     }
 //Using this for now until we get API workin
     private func generateMockRestData() -> [RestData] {
         var mockData: [RestData] = []

         // Generate data for the last 7 days
         for dayOffset in 1...7 {
             let date = Calendar.current.date(byAdding: .day, value: -dayOffset, to: Date())!
             let hoursSlept = Double.random(in: 6...9) // Random hours between 6 and 9
             mockData.append(RestData(id: UUID(), date: date, hoursSlept: hoursSlept))
         }

         return mockData
     }
 struct MainView: View {
     @StateObject var restViewModel = RestViewModel()

     var body: some View {
         NavigationView {
             List {
                 // Your other list items or content
                 NavigationLink(destination: RestPreferencesView(viewModel: restViewModel)) {
                     Text("Set Rest Preferences")
                 }
             }
             .navigationTitle("Main")
         }
     }
 }
 */


