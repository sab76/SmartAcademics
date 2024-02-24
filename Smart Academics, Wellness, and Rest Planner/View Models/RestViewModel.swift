//
//  RestViewModel.swift
//  Smart Academics, Wellness, and Rest Planner
//
//  Created by Haley Marts on 2/23/24.
//

import Foundation
import Combine

class RestViewModel: ObservableObject {
    @Published var data: [RestData] = []

    func fetchRestData() {
        // Fetch rest data from HealthKit or another source
    }
}

