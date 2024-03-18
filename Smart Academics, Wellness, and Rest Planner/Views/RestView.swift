import Foundation
import HealthKit
import SwiftUI

struct RestView: View {
    @ObservedObject var viewModel: RestViewModel

    var body: some View {
        NavigationView {
            List(viewModel.aggregatedData) { data in
                VStack(alignment: .leading) {
                    Text("Date: \(data.date, formatter: itemFormatter)")
                    Text("Total Hours Slept in Last 24 Hours: \(formatSleepTime(data.totalHoursSlept))")
                    Text("Predominant Sleep State: \(sleepStateText(data.predominantSleepState))")
                }
                .padding()
                .background(Color.blue.opacity(0.1))
                .cornerRadius(8)
                .padding(.vertical, 4)
            }
            .navigationTitle("Sleep")
        }
        .onAppear(perform: viewModel.fetchRestData)
    }

    private func formatSleepTime(_ totalHours: Double) -> String {
        let hours = Int(totalHours)
        let minutes = Int((totalHours - Double(hours)) * 60)
        return "\(hours)h \(minutes)m"
    }

    private func sleepStateText(_ state: HKCategoryValueSleepAnalysis) -> String {
        switch state {
        case .inBed:
            return "In Bed"
        case .asleep, .asleepUnspecified:
            return "Asleep"
        case .awake:
            return "Awake"
        case .asleepREM:
            return "REM Sleep"
        case .asleepCore:
            return "Core Sleep"
        case .asleepDeep:
            return "Deep Sleep"
        default:
            return "Unknown"
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .none
    return formatter
}()
