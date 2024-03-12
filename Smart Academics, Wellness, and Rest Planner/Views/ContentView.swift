import SwiftUI
import CoreData
import EventKit

struct ContentView: View {
    private let healthDataManager = HealthDataManager()
    
    // Directly instantiate view models as @StateObject with HealthDataManager
    @StateObject var restViewModel = RestViewModel(healthDataManager: HealthDataManager())
    @StateObject var fitnessViewModel = FitnessViewModel(healthDataManager: HealthDataManager())
    @StateObject var academicViewModel = AcademicScheduleViewModel(dataFetcher: APIDataFetcher())

    var body: some View {
        TabView {
            CoursesView(viewModel: academicViewModel)
                .tabItem {
                    Image(systemName: "calendar")
                    Text("Schedule")
                }
            
            FitnessView(viewModel: fitnessViewModel)
                .tabItem {
                    Image(systemName: "figure.walk")
                    Text("Fitness")
                }
            
            RestView(viewModel: restViewModel)
                .tabItem {
                    Image(systemName: "bed.double")
                    Text("Rest")
                }
            
            SettingsView(restViewModel: restViewModel)
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }
        }
    }
}


