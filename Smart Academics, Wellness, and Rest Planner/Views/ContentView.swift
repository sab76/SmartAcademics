//
//  ContentView.swift
//  Smart Academics, Wellness, and Rest Planner
//Code in here is what generates all the of the UI and elements u see on ur phone

import SwiftUI
import CoreData
import EventKit

struct ContentView: View {
    @StateObject var restViewModel = RestViewModel()
    // Use MockDataFetcher for mock data, switch to APIDataFetcher for API data later
    let viewModel = AcademicScheduleViewModel(dataFetcher: APIDataFetcher())

    var body: some View {
        TabView {
            // Use CoursesView for academic schedule
            CoursesView(viewModel: viewModel)
                .tabItem {
                    Image(systemName: "calendar")
                    Text("Schedule")
                }
            
            FitnessView()
                .tabItem {
                    Image(systemName: "figure.walk")
                    Text("Fitness")
                }
            
            RestView()
                .tabItem {
                    Image(systemName: "bed.double")
                    Text("Rest")
                }
    
            
            SettingsView(restViewModel: restViewModel)  // Pass the RestViewModel to SettingsView
                    .tabItem {
                        Image(systemName: "gear")
                        Text("Settings")
                }
        }
    }
}


struct SmartPlannerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}



