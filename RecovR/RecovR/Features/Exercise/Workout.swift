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
    var title: String
    init(timestamp: Date, title: String, category: Category) {
        self.title = title
        self.category = category
        self.timestamp = timestamp
    }
}

enum Exercise: String, Codable, CaseIterable {
    case pushUp = "Push Ups"
    case crunches = "Crunches"
    case lunges = "Lunges"
}

