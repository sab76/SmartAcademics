//
//   FitnessViewModel.swift
//  Smart Academics, Wellness, and Rest Planner


import Foundation
import Combine

class FitnessViewModel: ObservableObject {
    @Published var data: [FitnessData] = []
    // Property to trigger wellness insights display
    @Published var showWellnessInsights: Bool = false
    @Published var wellnessInsights: String = ""

    func fetchFitnessData() {
        data = generateMockData()
        // Call to update wellness insights based on the fetched data
        updateWellnessInsights()
    }

    func generateMockData() -> [FitnessData] {
        var mockData: [FitnessData] = []
        
        for week in 1...3 {
            for day in 1...7 {
                if Int.random(in: 1...2) == 1 {
                    let date = Calendar.current.date(byAdding: .day, value: -(week * 7 + day), to: Date()) ?? Date()
                    let steps = Int.random(in: 5000...15000)
                    let workoutMinutes = Int.random(in: 15...45)
                    // Generate mock values for new properties
                    let sleepHours = Int.random(in: 5...8)
                    let sleepQuality = ["Poor", "Average", "Good"].randomElement() ?? "Average"
                    // Optional mock recommendations
                    let activityRecommendation = ["Take a short walk", "Try a new sport", nil].randomElement() ?? nil
                    let studyLocationRecommendation = ["Quiet library corner", "Café with WiFi", nil].randomElement() ?? nil
                    let fitnessData = FitnessData(date: date, steps: steps, workoutMinutes: workoutMinutes, sleepHours: sleepHours, sleepQuality: sleepQuality, activityRecommendation: activityRecommendation, studyLocationRecommendation: studyLocationRecommendation)
                    mockData.append(fitnessData)
                }
            }
        }
        
        return mockData
    }

    // Example function to update wellness insights based on the fetched data
    private func updateWellnessInsights() {
        // This is a simplified example. In a real app, you might analyze trends or patterns in the data.
        let averageSleepHours = data.map { $0.sleepHours }.reduce(0, +) / max(data.count, 1)
        if averageSleepHours < 7 {
            wellnessInsights = "Your average sleep duration is below the recommended 7-9 hours. Consider adjusting your schedule for better rest."
        } else {
            wellnessInsights = "You're doing great with your sleep schedule! Keep it up for optimal health and focus."
        }
        showWellnessInsights = true
    }
}


