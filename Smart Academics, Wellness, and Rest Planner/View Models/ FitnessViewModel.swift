//
//   FitnessViewModel.swift
//  Smart Academics, Wellness, and Rest Planner
//
//  Created by Haley Marts on 2/23/24.
//

import Foundation
import Combine

class FitnessViewModel: ObservableObject {
    @Published var data: [FitnessData] = []

    func fetchFitnessData() {
        // This is where you'd fetch data from HealthKit or another source
    }
}
