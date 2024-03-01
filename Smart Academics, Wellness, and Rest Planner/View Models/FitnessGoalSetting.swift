//
//  FitnessGoalSetting.swift
//  Smart Academics, Wellness, and Rest Planner
//
//  Created by Haley Marts on 2/24/24.
//

import Foundation

import SwiftUI

struct FitnessGoalSettingsView: View {
    @State private var selectedFrequency: Int = 3
    @State private var selectedType: String = "Cardio"
    @State private var workoutDuration: Int = 30
    let workoutTypes = ["Cardio", "WeightLifting", "Yoga", "Mixed"]
    
    var body: some View {
        Form {
            Section(header: Text("Workout Frequency")) {
                Picker("Times per week", selection: $selectedFrequency) {
                    ForEach(1...7, id: \.self) { frequency in
                        Text("\(frequency)")
                    }
                }
            }
            
            Section(header: Text("Workout Type")) {
                Picker("Type", selection: $selectedType) {
                    ForEach(workoutTypes, id: \.self) { type in
                        Text(type)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            
            Section(header: Text("Workout Duration")) {
                Stepper(value: $workoutDuration, in: 10...120, step: 5) {
                    Text("\(workoutDuration) minutes")
                }
            }
            
            Button("Save Fitness Goals") {
                // Save action
                saveFitnessGoals()
            }
        }
        .navigationTitle("Fitness Goals")
    }
    
    func saveFitnessGoals() {
        let fitnessGoal = FitnessGoal(workoutFrequency: selectedFrequency, workoutType: selectedType, workoutDuration: workoutDuration)
        // save the fitnessGoal to your preferred storage method
        // For example, UserDefaults, CoreData, or send to an API
        print(fitnessGoal) // For demo purposes
    }
}
