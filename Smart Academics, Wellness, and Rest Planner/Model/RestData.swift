//
//  RestData.swift
//  Smart Academics, Wellness, and Rest Planner
//
//  Created by Haley Marts on 2/23/24.
//

import Foundation

struct RestData: Identifiable {
    var id = UUID()
    var date: Date
    var hoursSlept: Double
}
