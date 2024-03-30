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
    var title: String
    var technique: Technique
    init(timestamp: Date, title: String, category: Category, technique: Technique) {
        self.title = title
        self.category = category
        self.timestamp = timestamp
        self.technique = technique
    }
    
}

enum Technique: String, CaseIterable, Codable {
    case meditation = "Meditation"
    case deepBreath = "Deep Breathing"
    case mindfulness = "Mindfulness"
}
