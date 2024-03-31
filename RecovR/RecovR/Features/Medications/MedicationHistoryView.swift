//
//  MedicationHistoryView.swift
//  RecovR
//
//  Created by richard Haynes on 3/31/24.
//

import SwiftUI
import SwiftData
struct MedicationHistoryView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Query private var history: [MedicationHistory]
    var body: some View {
        List(history){ med in
            Text("\(med.dose) \(med.administration.rawValue)(s) of \(med.title) taken at \(med.dosageTime, format: Date.FormatStyle(date:.numeric, time: .shortened))")
        }
    }
}

#Preview {
    let container = try! ModelContainer(for: WorkoutHistory.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
    return MedicationHistoryView().modelContainer(container)
}
