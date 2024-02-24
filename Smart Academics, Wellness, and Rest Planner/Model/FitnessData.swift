//
//  FitnessData.swift
//  Smart Academics, Wellness, and Rest Planner


import Foundation

struct FitnessData: Identifiable {
    var id = UUID()
    var date: Date
    var steps: Int
    var workoutMinutes: Int
}

