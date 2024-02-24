//
//  SleepData.swift
//  Smart Academics, Wellness, and Rest Planner


import Foundation

struct SleepData: Identifiable {
    var id: UUID = UUID()  // unique identifier for each sleep data entry
    var date: Date  //  date of the sleep analysis
    var hoursSlept: Double  //  number of hours slept
    // will add any other relevant properties we may need for sleep analysis
}

