//
//  RestView.swift
//  Smart Academics, Wellness, and Rest Planner


import Foundation
import SwiftUI

struct RestView: View {
    @ObservedObject var viewModel = RestViewModel()

    var body: some View {
        List(viewModel.data) { data in
            VStack(alignment: .leading) {
                Text("Date: \(data.date, formatter: itemFormatter)")
                Text("Hours Slept: \(data.hoursSlept, specifier: "%.2f")")
                    .padding(.top, 2)
            }
        }
        .onAppear(perform: viewModel.fetchRestData)
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .none
    return formatter
}()

