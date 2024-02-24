//
//  RestViewModel.swift
//  Smart Academics, Wellness, and Rest Planner


import Foundation
import Combine

class RestViewModel: ObservableObject {
    @Published var data: [RestData] = []

    func fetchRestData() {
        // For now, we'll use mock data
        self.data = generateMockRestData()
    }

    private func generateMockRestData() -> [RestData] {
        var mockData: [RestData] = []

        // Generate data for the last 7 days
        for dayOffset in 1...7 {
            let date = Calendar.current.date(byAdding: .day, value: -dayOffset, to: Date())!
            let hoursSlept = Double.random(in: 6...9) // Random hours between 6 and 9
            mockData.append(RestData(id: UUID(), date: date, hoursSlept: hoursSlept))
        }

        return mockData
    }
}


