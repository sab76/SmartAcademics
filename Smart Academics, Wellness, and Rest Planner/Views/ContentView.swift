//
//  ContentView.swift
//  Smart Academics, Wellness, and Rest Planner
//
//  Created by Haley Marts on 2/21/24.
//Code in here is what generates all the of the UI and elements u see on ur phone

import SwiftUI
import CoreData


// Main Tab Controller
struct  ContentView: View {
    var body: some View {
        TabView {
            ScheduleView()
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

            SettingsView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }
        }
    }
}

// Schedule View
struct ScheduleView: View {
    @StateObject private var viewModel = AcademicScheduleViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.assignments) { assignment in
                VStack(alignment: .leading) {
                    Text(assignment.name)
                    // Display additional assignment details here
                }
            }
            .navigationTitle("Academic Schedule")
            .onAppear {
                // Example course IDs - replace these with the actual IDs
                let courseIds = [34080, 12345, 67890]
                viewModel.fetchAssignments(forCourseIds: courseIds, userId: "hmarts")
            }
        }
    }
}






// Start point of your SwiftUI app

struct SmartPlannerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
