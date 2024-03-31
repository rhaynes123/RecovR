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
            WorkoutHistory.self,
            Medication.self,
            MedicationHistory.self,
            Contemplation.self,
            ContemplationHistory.self
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
    init() {
        // How To find the raw data
        // https://www.youtube.com/watch?v=CAr_1kcf2_c&t=1864s
        print(URL.applicationSupportDirectory.path(percentEncoded: false))
    }
}
