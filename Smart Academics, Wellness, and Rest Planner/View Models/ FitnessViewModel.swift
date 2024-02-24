//
//   FitnessViewModel.swift
//  Smart Academics, Wellness, and Rest Planner


import Foundation
import Combine

class FitnessViewModel: ObservableObject {
    @Published var data: [FitnessData] = []

    func fetchFitnessData() {
        // This is where we will fetch data from HealthKit 
    }
}
