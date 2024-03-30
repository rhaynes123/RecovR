//
//  RecovRApp.swift
//  RecovR
//
//  Created by richard Haynes on 3/25/24.
//

import SwiftUI
import SwiftData

@main
struct RecovRApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Workout.self,
            Medication.self,
            Contemplation.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            MainView()
        }
        .modelContainer(sharedModelContainer)
    }
}
