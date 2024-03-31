//
//  WorkoutHistoryView.swift
//  RecovR
//
//  Created by richard Haynes on 3/30/24.
//

import SwiftUI
import SwiftData
struct WorkoutHistoryView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var history: [WorkoutHistory]
    var body: some View {
        List(history){ workout in
            Text("\(workout.sets) sets x \(workout.reps) reps of \(workout.exercise.rawValue) done between \(workout.startTime, format: Date.FormatStyle(date:.numeric, time: .shortened)) and \(workout.endTime, format: Date.FormatStyle(date:.numeric, time: .shortened))")
            
        }
    }
}

#Preview {
    let container = try! ModelContainer(for: WorkoutHistory.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
    for index in 0...5 {
        container.mainContext.insert(WorkoutHistory(exercise: .crunches, startTime: Date(), endTime: Date(), sets: index, reps: index))
    }
    return WorkoutHistoryView().modelContainer(container)
}
