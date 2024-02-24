//
//  Smart_Academics__Wellness__and_Rest_PlannerApp.swift
//  Smart Academics, Wellness, and Rest Planner
//
//  Created by Haley Marts on 2/21/24.
//Entry points creating a brand new screen --> Contentview

import SwiftUI

@main
struct Smart_Academics__Wellness__and_Rest_PlannerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
