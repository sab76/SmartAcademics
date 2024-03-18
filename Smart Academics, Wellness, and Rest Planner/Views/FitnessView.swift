import Foundation
import SwiftUI

extension Date {
    func isSameDay(as otherDate: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.isDate(self, inSameDayAs: otherDate)
    }
}

struct FitnessView: View {
    @ObservedObject var viewModel: FitnessViewModel
    
    @State private var selectedDate: Date? = Date()
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.showWellnessInsights {
                    GroupBox(label: Text("Wellness Insights")) {
                        Text(viewModel.wellnessInsights)
                            .padding()
                    }
                    .padding()
                }
                
                TabView {
                    ForEach(viewModel.data.filter { $0.date.isSameDay(as: selectedDate ?? Date()) }) { data in
                        dailySummaryView(data: data)
                            .tabItem {
                                Image(systemName: "calendar")
                                Text("\(data.date, formatter: Self.dateFormatter)")
                            }
                    }
                }
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(viewModel.data, id: \.id) { data in
                            Button(action: {
                                self.selectedDate = data.date
                            }) {
                                Text("\(data.date, formatter: Self.dateFormatter)")
                                    .padding()
                                    .background(self.selectedDate == data.date ? Color.blue : Color.gray)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Fitness")
        }
        .onAppear {
            viewModel.fetchFitnessAndActivityData()
        }
    }
    
    func dailySummaryView(data: FitnessData) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Steps: \(data.steps)")
            Text("Activity Minutes: \(data.activityMinutes)")
            Text("Sleep Hours: \(data.sleepHours) hours")
            Text("Sleep Quality: \(data.sleepQuality)")
            if let activityRecommendation = data.activityRecommendation {
                Text("Activity Recommendation: \(activityRecommendation)")
            }
            if let studyLocation = data.studyLocationRecommendation {
                Text("Study Location: \(studyLocation)")
            }
        }
        .padding()
    }
    
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }()
}
