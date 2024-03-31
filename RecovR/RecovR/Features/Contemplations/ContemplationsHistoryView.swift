//
//  ContemplationsHistoryView.swift
//  RecovR
//
//  Created by richard Haynes on 3/31/24.
//

import SwiftUI
import SwiftData
struct ContemplationsHistoryView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var history: [ContemplationHistory]
    var body: some View {
        List(history){ contemplation in
            Text("\(contemplation.technique.rawValue) done between \(contemplation.startTime, format: Date.FormatStyle(date:.numeric, time: .shortened)) and \(contemplation.endTime, format: Date.FormatStyle(date:.numeric, time: .shortened))")
            
        }
    }
}

#Preview {
    let container = try! ModelContainer(for: ContemplationHistory.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
    return ContemplationsHistoryView().modelContainer(container)
}
