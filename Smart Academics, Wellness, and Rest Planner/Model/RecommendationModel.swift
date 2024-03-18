//
//  RecommendationModel.swift
//  Smart Academics, Wellness, and Rest Planner
//
//  Created by Haley Marts on 3/17/24.
//

import Foundation

struct DailyRecommendation: Identifiable {
    let id = UUID()
    var recommendation: String
}

struct Recommendation: Identifiable {
    var id: UUID = UUID()
    var title: String
    var description: String
    var category: RecommendationCategory
}

enum RecommendationCategory {
    case academic, wellness, fitness, rest
}
