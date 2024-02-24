//
//  RestViewModel.swift
//  Smart Academics, Wellness, and Rest Planner


import Foundation
import Combine

class RestViewModel: ObservableObject {
    @Published var data: [RestData] = []

    func fetchRestData() {
        // Fetch rest data from HealthKit and or another source
    }
}

