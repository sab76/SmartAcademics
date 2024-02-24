//
//  RestView.swift
//  Smart Academics, Wellness, and Rest Planner


import Foundation
import SwiftUI

struct RestView: View {
    @ObservedObject var viewModel = RestViewModel()

    var body: some View {
        List {
            ForEach(viewModel.data) { data in
                VStack(alignment: .leading) {
                    Text("Date: \(data.date, formatter: itemFormatter)")
                    Text("Hours Slept: \(data.hoursSlept, specifier: "%.2f") hours")
                        .padding(.top, 2)
                }
                .padding()
                .background(Color.blue.opacity(0.1))
                .cornerRadius(8)
                .padding(.vertical, 4)
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


