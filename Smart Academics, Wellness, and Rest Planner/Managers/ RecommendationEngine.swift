import Foundation

class RecommendationEngine {
    func generateDailyRecommendations(academicItems: [AcademicItem], fitnessData: [FitnessData], sleepData: [SleepData], now: Date = Date()) -> [Recommendation] {
        var recommendations: [Recommendation] = []
        
        if let sleepRecommendation = generateSleepRecommendation(sleepData: sleepData, now: now) {
            recommendations.append(sleepRecommendation)
        }

        let academicRecommendation = generateAcademicRecommendation(academicItems: academicItems, now: now)
        recommendations.append(contentsOf: academicRecommendation)

        if let fitnessRecommendation = generateFitnessRecommendation(fitnessData: fitnessData, academicItems: academicItems, now: now) {
            recommendations.append(fitnessRecommendation)
        }
        
        return recommendations
    }
    
    private func generateSleepRecommendation(sleepData: [SleepData], now: Date) -> Recommendation? {
           // Assuming sleepData can be used similarly to restData
           guard !sleepData.isEmpty else { return nil }
           
        let averageSleepStartHour = calculateAverageSleepStartHour(sleepData: sleepData)
           let currentHour = Calendar.current.component(.hour, from: now)
           
           if isWithinSleepWindow(currentHour: currentHour, averageSleepHour: averageSleepStartHour) {
               return Recommendation(
                   title: "Time to Sleep",
                   description: "It's getting close to your usual bedtime. Consider winding down for the night.",
                   category: .rest
               )
           }
           
           return nil
       }
    
    private func calculateAverageSleepStartHour(sleepData: [SleepData]) -> Int {
           let totalSleepStartHour = sleepData.reduce(0) { (acc, data) in
               acc + Calendar.current.component(.hour, from: data.date)
           }
           return totalSleepStartHour / sleepData.count
       }
    
    private func isWithinSleepWindow(currentHour: Int, averageSleepHour: Int) -> Bool {
        // Assuming the sleep window is 1 hour before and after the average sleep time
        let sleepWindowStart = (averageSleepHour - 1 + 24) % 24  // Adjust for 24-hour clock
        let sleepWindowEnd = (averageSleepHour + 1) % 24
        
        if sleepWindowStart < sleepWindowEnd {
            return currentHour >= sleepWindowStart && currentHour <= sleepWindowEnd
        } else {
            // Handles cases where the sleep window crosses midnight
            return currentHour >= sleepWindowStart || currentHour <= sleepWindowEnd
        }
    }
    
    private func generateAcademicRecommendation(academicItems: [AcademicItem], now: Date) -> [Recommendation] {
        let sortedAcademicItems = academicItems.sorted { (firstItem, secondItem) in
            if firstItem.deadline == secondItem.deadline {
                return firstItem.points > secondItem.points
            }
            return firstItem.deadline < secondItem.deadline
        }
        
        if let urgentAssignment = sortedAcademicItems.first(where: { Calendar.current.isDateInToday($0.deadline) }) {
            let recommendation = Recommendation(
                title: "Urgent Assignment",
                description: "Focus on your upcoming assignment: \(urgentAssignment.title), worth \(urgentAssignment.points) points",
                category: .academic
            )
            return [recommendation]
        }
        
        return []
    }
    
    private func generateFitnessRecommendation(fitnessData: [FitnessData], academicItems: [AcademicItem], now: Date) -> Recommendation? {
        let exerciseMinutesGoalPerDay = 30
        let exerciseMinutesGoalPerWeek = exerciseMinutesGoalPerDay * 7
        
        let totalActivityMinutesThisWeek = fitnessData.reduce(0) { $0 + $1.activityMinutes }
        
        let hasUrgentAssignments = academicItems.contains {
            Calendar.current.isDateInToday($0.deadline) || Calendar.current.isDateInTomorrow($0.deadline)
        }
        
        if hasUrgentAssignments && totalActivityMinutesThisWeek >= exerciseMinutesGoalPerWeek * Int(0.75) {
            return Recommendation(
                id: UUID(),
                title: "Urgent Assignments",
                description: "You have urgent assignments due. Focus on your studies but try to fit in some light exercise if possible.",
                category: .academic
            )
        } else if totalActivityMinutesThisWeek < exerciseMinutesGoalPerWeek {
            return Recommendation(
                id: UUID(),
                title: "Fitness Goal",
                description: "You're behind on your weekly fitness goal. Plan for more activity in the coming days.",
                category: .fitness
            )
        }
        
        return nil
    }
    
    
    
}
