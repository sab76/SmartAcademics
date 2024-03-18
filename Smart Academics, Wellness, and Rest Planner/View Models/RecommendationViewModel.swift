//
//  RecommendationViewModel.swift
//  Smart Academics, Wellness, and Rest Planner

import Foundation
import Combine

class RecommendationViewModel: ObservableObject {
    @Published var recommendations: [Recommendation] = []
    private var recommendationEngine = RecommendationEngine()
    private var academicViewModel: AcademicScheduleViewModel
    private var fitnessViewModel: FitnessViewModel
    private var restViewModel: RestViewModel

    init(academicViewModel: AcademicScheduleViewModel, fitnessViewModel: FitnessViewModel, restViewModel: RestViewModel) {
        self.academicViewModel = academicViewModel
        self.fitnessViewModel = fitnessViewModel
        self.restViewModel = restViewModel
        updateRecommendations()
    }
    
    func updateRecommendations() {
        // Mapping assignments to AcademicItem
        let academicItems: [AcademicItem] = academicViewModel.assignmentsByCourseId.flatMap { courseId, assignments in
            assignments.compactMap { assignment in
                // Correctly accessing properties from `assignment`
                AcademicItem(
                    id: UUID(),
                    title: assignment.name,
                    deadline: assignment.dueAt ?? Date(),
                    description: assignment.description ?? "",
                    points: Int(assignment.pointsPossible)
                )
            }
        }

        // Directly using SleepData if it's functionally equivalent to RestData
        let sleepData = restViewModel.data.map { SleepData(id: $0.id, date: $0.date, hoursSlept: $0.hoursSlept, sleepState: $0.sleepState) }
        
        // Use the fitness data from the FitnessViewModel
        let fitnessData = fitnessViewModel.data
        
        // Adjust the recommendation engine to accept SleepData if RestData is not needed
        // This part of the code assumes the engine can work with SleepData, or you need to map SleepData to RestData accordingly
        recommendations = recommendationEngine.generateDailyRecommendations(
            academicItems: academicItems,
            fitnessData: fitnessData,
            sleepData: sleepData // Assuming your RecommendationEngine can use SleepData directly
        )
    }
}







