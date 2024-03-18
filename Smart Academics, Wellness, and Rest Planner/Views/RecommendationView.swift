//
//  RecommendationView.swift
//  Smart Academics, Wellness, and Rest Planner
//
//  Created by Haley Marts on 3/14/24.
//


import Foundation
import SwiftUI

struct RecommendationView: View {
    @ObservedObject var viewModel: RecommendationViewModel
    
    var body: some View {
        NavigationView {
            List(viewModel.recommendations) { recommendation in
                VStack(alignment: .leading) {
                    Text(recommendation.title)
                        .font(.headline)
                    Text(recommendation.description)
                        .font(.subheadline)
                }
                .padding()
            }
            .navigationTitle("Recommendations")
        }
        .onAppear {
            viewModel.updateRecommendations()
        }
    }
}



