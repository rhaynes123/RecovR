//
//  MedicationHistoryView.swift
//  RecovR
//
//  Created by richard Haynes on 3/31/24.
//

import SwiftUI
import SwiftData
import Charts
struct MedicationHistoryView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Query private var history: [MedicationHistory]
    var body: some View {
        VStack {
            Text("Medication History")
            let totalDoses =  history.reduce(0){$0 + ($1.dose)}
            let lastMedication : MedicationHistory?  = history.last
            
            Text("\(totalDoses, format: .number) total treatments as of \(lastMedication?.dosageTime ?? Date(), format: Date.FormatStyle(date: .abbreviated))").font(.footnote)
            Chart  {
               
                ForEach(history){ cont in
                    BarMark(
                        x: .value("Mental Technique", cont.administration.rawValue) ,
                        y: .value("Total Duration", cont.dose)
                    ).foregroundStyle(Color.yellow.gradient)
                    
                }
            }
        }
        List(history){ med in
            Text("\(med.dose) \(med.administration.rawValue)(s) of \(med.title) taken at \(med.dosageTime, format: Date.FormatStyle(date:.numeric, time: .shortened))")
        }
    }
}

#Preview {
    let container = try! ModelContainer(for: MedicationHistory.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
    for _ in 0...10 {
        let history = MedicationHistory(administration: .pill, startTime: Date(), dose: 2, title: "Oxicodone")
        container.mainContext.insert(history)
    }
    for _ in 0...20 {
        let history = MedicationHistory(administration: .injection, startTime: Date(), dose: 2, title: "Steriods")
        container.mainContext.insert(history)
    }
    return MedicationHistoryView().modelContainer(container)
}
