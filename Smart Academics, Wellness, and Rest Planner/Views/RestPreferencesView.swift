// RestPreferencesView.swift
//  Smart Academics, Wellness, and Rest Planner


import Foundation
import SwiftUI

struct RestPreferencesView: View {
    @ObservedObject var viewModel: RestViewModel
    
    init(viewModel: RestViewModel) {
            self.viewModel = viewModel
        }

    @State private var sleepGoalHours: Double = 8.0 // Default sleep goal
    @State private var quietHoursStart: Date = Calendar.current.startOfDay(for: Date())
    @State private var quietHoursEnd: Date = Calendar.current.startOfDay(for: Date()).addingTimeInterval(8 * 3600) // 8 hours later
    
    var body: some View {
        Form {
            Section(header: Text("Sleep Goal")) {
                VStack(alignment: .leading) {
                    Slider(value: $sleepGoalHours, in: 4...12, step: 0.5)
                    Text("Goal: \(sleepGoalHours, specifier: "%.1f") hours")
                }
            }
            
            Section(header: Text("Quiet Hours")) {
                DatePicker("Start", selection: $quietHoursStart, displayedComponents: .hourAndMinute)
                DatePicker("End", selection: $quietHoursEnd, displayedComponents: .hourAndMinute)
            }
        }
        .navigationTitle("Rest Preferences")
    }
}
