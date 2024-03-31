//
//  WorkoutHistoryView.swift
//  RecovR
//
//  Created by richard Haynes on 3/30/24.
//

import SwiftUI
import SwiftData
import Charts
struct WorkoutHistoryView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var history: [WorkoutHistory]
    var body: some View {
        VStack {
            Text("Workouts Completed")
            let totalReps = history.reduce(0){$0 + ($1.reps * $1.sets)}
            let lastworkout : WorkoutHistory?  = history.last
            
            Text("\(totalReps) total reps as of \(lastworkout?.endTime ?? Date(), format: Date.FormatStyle(date: .abbreviated))").font(.footnote)
            Chart  {
               
                ForEach(history){ workout in
                    BarMark(
                        x: .value("Exercise", workout.exercise.rawValue) ,
                        y: .value("Total Reps", workout.reps)
                    ).foregroundStyle(Color.green.gradient)
                    
                }
            }
        }
        
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
    for index in 0...15 {
        container.mainContext.insert(WorkoutHistory(exercise: .lunges, startTime: Date(), endTime: Date(), sets: index, reps: index))
    }
    return WorkoutHistoryView().modelContainer(container)
}
