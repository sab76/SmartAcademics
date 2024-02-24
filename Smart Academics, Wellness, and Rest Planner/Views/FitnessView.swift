//
//  FitnessView.swift
//  Smart Academics, Wellness, and Rest Planner
//
//  Created by Haley Marts on 2/23/24.
//

import Foundation
import SwiftUI

struct FitnessView: View {
    @ObservedObject var viewModel = FitnessViewModel()

    var body: some View {
        List(viewModel.data) { data in
            VStack(alignment: .leading) {
                Text("Steps: \(data.steps)")
                Text("Workout Minutes: \(data.workoutMinutes)")
                    .padding(.top, 2)
            }
        }
        .onAppear(perform: viewModel.fetchFitnessData)
    }
}
