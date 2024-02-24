//
//  ContentView.swift
//  Smart Academics, Wellness, and Rest Planner
//Code in here is what generates all the of the UI and elements u see on ur phone

import SwiftUI
import CoreData
import EventKit

// Main Tab Controller
struct  ContentView: View {
    var body: some View {
        TabView {
            AcademicScheduleView()
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


    
    struct SmartPlannerApp: App {
        var body: some Scene {
            WindowGroup {
                ContentView()
            }
        }
    }

