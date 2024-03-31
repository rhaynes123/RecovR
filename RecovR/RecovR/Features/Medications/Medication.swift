//
//  Medication.swift
//  RecovR
//
//  Created by richard Haynes on 3/26/24.
//

import Foundation
import SwiftData
@Model
final class Medication: Activity {
    var category: Category
    var administration : Adminstration
    var timestamp: Date
    var title: String
    var dose: Int
    init(timestamp: Date, administration: Adminstration, title: String, category: Category, dose: Int) {
        self.title = title
        self.administration = administration
        self.category = category
        self.timestamp = timestamp
        self.dose = dose
    }
}

@Model
final class MedicationHistory {
    var administration : Adminstration
    var dosageTime : Date
    var dose: Int
    var title: String
    init(administration: Adminstration, startTime: Date, dose: Int, title: String) {
        self.administration = administration
        self.dosageTime = startTime
        self.dose = dose
        self.title = title
    }
}

enum Adminstration: String, Codable, CaseIterable {
    case pill = "Pill"
    case teaspoon = "Teaspoon"
    case injection = "Injection"
}
