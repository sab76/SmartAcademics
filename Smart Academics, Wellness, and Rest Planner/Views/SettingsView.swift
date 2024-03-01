//
//  SettingsView.swift
//  Smart Academics, Wellness, and Rest Planner


import Foundation
import SwiftUI

struct SettingsView: View {
    @ObservedObject var restViewModel: RestViewModel  // Add this line to accept the RestViewModel
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("General")) {
                    NavigationLink("Account", destination: AccountSettingsView())
                    NavigationLink("Notifications", destination: NotificationSettingsView())
                }
               
                Section(header: Text("Rest & Downtime")) {
                    NavigationLink("Sleep Goals & Quiet Hours", destination: RestPreferencesView(viewModel: restViewModel))
                                }
                // Updating the SettingsView to include a navigation link to the CanvasIntegrationSettingsView
                // Canvas Integration Section
                Section(header: Text("Integration")) {
                    NavigationLink("Canvas Integration", destination: CanvasIntegrationSettingsView())
                }
            
                    NavigationLink("Data Privacy", destination: PrivacySettingsView())
                    NavigationLink("Fitness Goals", destination: FitnessGoalSettingsView())

                }
            }
            .navigationTitle("Settings")
        }
    }




