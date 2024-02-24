//
//  SettingsView.swift
//  Smart Academics, Wellness, and Rest Planner


import Foundation
import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("General")) {
                    NavigationLink("Account", destination: AccountSettingsView())
                    NavigationLink("Notifications", destination: NotificationSettingsView())
                }
                // Example of adding more settings sections
                Section(header: Text("Preferences")) {
                    NavigationLink("App Theme", destination: ThemeSettingsView())
                    NavigationLink("Data Privacy", destination: PrivacySettingsView())
                }
            }
            .navigationTitle("Settings")
        }
    }
}


