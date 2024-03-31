//
//  Contemplation.swift
//  RecovR
//
//  Created by richard Haynes on 3/28/24.
//

import Foundation
import SwiftData
@Model
final class Contemplation: Activity {
    var category: Category
    var timestamp: Date
    var technique: Technique
    init(timestamp: Date, category: Category, technique: Technique) {
        
        self.category = category
        self.timestamp = timestamp
        self.technique = technique
    }
    
}

@Model
final class ContemplationHistory {
    var technique: Technique
    var startTime : Date
    var endTime : Date
    init(technique: Technique, startTime: Date, endTime: Date) {
        self.technique = technique
        self.startTime = startTime
        self.endTime = endTime
    }
}

enum Technique: String, CaseIterable, Codable {
    case meditation = "Meditation"
    case deepBreath = "Deep Breathing"
    case mindfulness = "Mindfulness"
}
