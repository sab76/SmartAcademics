//
//  FitnessView.swift
//  Smart Academics, Wellness, and Rest Planner


import Foundation
import SwiftUI

struct FitnessView: View {
    @ObservedObject var viewModel = FitnessViewModel()

    // Define a static date formatter
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }()

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                ForEach(viewModel.data) { data in
                    GroupBox(label: Text("Daily Summary: \(data.date, formatter: Self.dateFormatter)")) {
                        VStack(alignment: .leading) {
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
                        .padding(.top, 2)
                    }
                }
                if viewModel.showWellnessInsights {
                    GroupBox(label: Text("Wellness Insights")) {
                        Text(viewModel.wellnessInsights)
                    }
                }
            }
            .padding()
        }
        .onAppear {
            viewModel.fetchFitnessData()
        }
    }
}




