//
//  Workout.swift
//  RecovR
//
//  Created by richard Haynes on 3/29/24.
//

import Foundation
import SwiftData


@Model
final class Workout: Activity {
    var category: Category
    
    var timestamp: Date
    var exercise: Exercise
    init(timestamp: Date, exercise: Exercise, category: Category) {
        self.exercise = exercise
        self.category = category
        self.timestamp = timestamp
    }
}

@Model
final class WorkoutHistory {
    var exercise: Exercise
    var startTime : Date
    var endTime : Date
    var sets: Int
    var reps: Int
    init(exercise: Exercise, startTime: Date, endTime: Date, sets: Int, reps: Int) {
        self.exercise = exercise
        self.startTime = startTime
        self.endTime = endTime
        self.sets = sets
        self.reps = reps
    }
}
enum Exercise: String, Codable, CaseIterable {
    case pushUp = "Push Ups"
    case crunches = "Crunches"
    case lunges = "Lunges"
}

