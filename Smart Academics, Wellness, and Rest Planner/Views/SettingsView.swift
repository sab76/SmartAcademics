//
//  SettingsView.swift
//  Smart Academics, Wellness, and Rest Planner


import Foundation
import SwiftUI

struct SettingsView: View {
    var body: some View {
        Form {
            // Add settings options here
            Section(header: Text("General")) {
                Text("Account")
                Text("Notifications")
            }
        }
        .navigationTitle("Settings")
    }
}

