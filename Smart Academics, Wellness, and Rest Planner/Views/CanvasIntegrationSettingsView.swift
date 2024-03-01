//
//  CanvasIntegrationSettingsView.swift
//  Smart Academics, Wellness, and Rest Planner


import Foundation
import SwiftUI

// Making a model for the Canvas integration settings for better state management
class CanvasIntegrationSettingsModel: ObservableObject {
    @Published var receiveAssignmentsNotifications: Bool = false
    @Published var receiveGradesNotifications: Bool = false
    @Published var receiveAnnouncementsNotifications: Bool = false
    @Published var syncFrequency: SyncFrequency = .daily
    //With our real app, we might have a more complex type here
    @Published var dataPointPriorities: [String] = ["Assignments", "Grades", "Announcements"]


    enum SyncFrequency: String, CaseIterable, Identifiable {
        case hourly = "Hourly"
        case daily = "Daily"
        case weekly = "Weekly"
        
        var id: String { self.rawValue }
    }
}

struct CanvasIntegrationSettingsView: View {
    @StateObject private var settingsModel = CanvasIntegrationSettingsModel()

    var body: some View {
        Form {
            Section(header: Text("Notifications")) {
                Toggle("Assignments", isOn: $settingsModel.receiveAssignmentsNotifications)
                Toggle("Grades", isOn: $settingsModel.receiveGradesNotifications)
                Toggle("Announcements", isOn: $settingsModel.receiveAnnouncementsNotifications)
            }
            
            Section(header: Text("Sync Frequency")) {
                Picker("Sync Frequency", selection: $settingsModel.syncFrequency) {
                    ForEach(CanvasIntegrationSettingsModel.SyncFrequency.allCases) { frequency in
                        Text(frequency.rawValue).tag(frequency)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            Section(header: Text("Prioritize Data Points")) {
                           // Using EditButton to enable editing mode for List
                           EditButton()

                List {
                    ForEach(settingsModel.dataPointPriorities, id: \.self) { dataPoint in
                        Text(dataPoint)
                    }
                    .onMove(perform: moveDataPoints)
                    
                }
            
            // Add more settings here as needed
        }
        .navigationTitle("Canvas Integration")
    }
}

        // Our Function to rearrange data points based on user's preference
            func moveDataPoints(from source: IndexSet, to destination: Int) {
                settingsModel.dataPointPriorities.move(fromOffsets: source, toOffset: destination)
            }
        }
