//
//  Activity.swift
//  RecovR
//
//  Created by richard Haynes on 3/26/24.
//

import Foundation

enum Category: String, CaseIterable, Codable {
    case exercise = "Exercise"
    case medication = "Medication"
   // case water = "Water"
    case contemplation = "Contemplation"
}

protocol Activity{
    var category: Category { get set }
}
