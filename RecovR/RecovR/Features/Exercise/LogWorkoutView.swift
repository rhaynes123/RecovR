//
//  LogWorkoutView.swift
//  RecovR
//
//  Created by richard Haynes on 3/30/24.
//

import SwiftUI
import SwiftData
struct LogWorkoutView : View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @Query private var exercises: [WorkoutHistory]
    @State private var startTime : Date = Date()
    @State private var endTime : Date = Date()
    @State private var sets: Int = 0
    @State private var reps: Int = 0
    var workout : Workout
    init(workout: Workout) {
        self.workout = workout
    }
    
    private func log(entry: WorkoutHistory){
        modelContext.insert(entry)
    }
    var body: some View {
        VStack {
            Form {
                Text("Name: \(workout.exercise.rawValue)")
                
                Section {
                    TextField("Sets:", value: $sets, format: .number)
                } header: {
                    Text("Sets")
                }
                
                Section {
                    TextField("Reps:", value: $reps, format: .number)
                } header: {
                    Text("Reps")
                }
                
                DatePicker("Start Time", selection: $startTime)
                DatePicker("End Time", selection: $endTime)
                
                Button("Log"){
                    let entry = WorkoutHistory(exercise: workout.exercise, startTime: startTime, endTime: endTime, sets: sets, reps: reps)
                    log(entry: entry)
                    dismiss()
                }
            }
        }
    }
    
}

#Preview {
    let container = try! ModelContainer(for: WorkoutHistory.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
    let workout = Workout(timestamp: Date(), exercise: .lunges , category: .exercise)
    return LogWorkoutView(workout: workout).modelContainer(container)
}
