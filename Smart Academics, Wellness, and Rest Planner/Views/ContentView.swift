import SwiftUI
import CoreData
import EventKit

struct ContentView: View {
    private let healthDataManager = HealthDataManager()
    
    @StateObject var restViewModel: RestViewModel
    @StateObject var fitnessViewModel: FitnessViewModel
    @StateObject var academicViewModel: AcademicScheduleViewModel
    @StateObject var recommendationViewModel: RecommendationViewModel

    init() {
        let healthDataManager = HealthDataManager()
        let academicViewModel = AcademicScheduleViewModel(dataFetcher: APIDataFetcher())
        let fitnessViewModel = FitnessViewModel(healthDataManager: healthDataManager)
        let restViewModel = RestViewModel(healthDataManager: healthDataManager)
        let recommendationViewModel = RecommendationViewModel(academicViewModel: academicViewModel, fitnessViewModel: fitnessViewModel, restViewModel: restViewModel)

        _academicViewModel = StateObject(wrappedValue: academicViewModel)
        _fitnessViewModel = StateObject(wrappedValue: fitnessViewModel)
        _restViewModel = StateObject(wrappedValue: restViewModel)
        _recommendationViewModel = StateObject(wrappedValue: recommendationViewModel)
    }

    var body: some View {
        TabView {
            RecommendationView(viewModel: recommendationViewModel)
                .tabItem {
                    Image(systemName: "lightbulb")
                    Text("Recommendation")
                }
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
