//
//  FitnessView.swift
//  Smart Academics, Wellness, and Rest Planner

import Foundation
import SwiftUI

struct FitnessView: View {
    @ObservedObject var viewModel = FitnessViewModel()
    
    // Current date tab
    @State private var selectedDate: Date? = Date()
    
    var body: some View {
        VStack {
            // Wellness Insights at the top
            if viewModel.showWellnessInsights {
                GroupBox(label: Text("Wellness Insights")) {
                    Text(viewModel.wellnessInsights)
                        .padding()
                }
                .padding()
            }
            
            // Display the current day in a tab
            TabView {
                ForEach(viewModel.data.filter { $0.date.isSameDay(as: selectedDate) }) { data in
                    dailySummaryView(data: data)
                        .tabItem {
                            Image(systemName: "calendar")
                            Text("\(data.date, formatter: Self.dateFormatter)")
                        }
                }
            }
            
            // Navigation to view past days
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(viewModel.data, id: \.id) { data in
                        Button(action: {
                            self.selectedDate = data.date
                        }) {
                            Text("\(data.date, formatter: Self.dateFormatter)")
                                .padding()
                                .background(self.selectedDate == data.date ? Color.blue : Color.gray)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                }
                .padding()
            }
        }
        .onAppear {
            viewModel.fetchFitnessData()
        }
    }
    
    func dailySummaryView(data: FitnessData) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Steps: \(data.steps)")
            Text("Workout Minutes: \(data.workoutMinutes)")
            Text("Sleep Hours: \(data.sleepHours) hours")
            Text("Sleep Quality: \(data.sleepQuality)")
            if let activityRecommendation = data.activityRecommendation {
                Text("Activity Recommendation: \(activityRecommendation)")
            }
            if let studyLocation = data.studyLocationRecommendation {
                Text("Study Location: \(studyLocation)")
            }
        }
        .padding()
    }
    
    // Define a static date formatter
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }()
}

extension Date {
    func isSameDay(as otherDate: Date?) -> Bool {
        guard let otherDate = otherDate else { return false }
        let calendar = Calendar.current
        return calendar.isDate(self, inSameDayAs: otherDate)
    }
}
