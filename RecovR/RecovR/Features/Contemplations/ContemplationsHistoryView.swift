//
//  ContemplationsHistoryView.swift
//  RecovR
//
//  Created by richard Haynes on 3/31/24.
//

import SwiftUI
import SwiftData
import Charts
struct ContemplationsHistoryView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var history: [ContemplationHistory]
    var body: some View {
        VStack {
            Text("Mental Contemplations")
            let totalTime = history.reduce(0){$0 + ($1.endTime.timeIntervalSince($1.startTime))}
            let lastContemplation : ContemplationHistory?  = history.last
            
            Text("\(totalTime / 60 , format: .number) total minutes in contemplation as of \(lastContemplation?.endTime ?? Date(), format: Date.FormatStyle(date: .abbreviated))").font(.footnote)
            Chart  {
               
                ForEach(history){ cont in
                    BarMark(
                        x: .value("Mental Technique", cont.technique.rawValue) ,
                        y: .value("Total Duration", cont.endTime.timeIntervalSince(cont.startTime))
                    ).foregroundStyle(Color.blue.gradient)
                    
                }
            }
        }
        List(history){ contemplation in
            Text("\(contemplation.technique.rawValue) done between \(contemplation.startTime, format: Date.FormatStyle(date:.numeric, time: .shortened)) and \(contemplation.endTime, format: Date.FormatStyle(date:.numeric, time: .shortened))")
            
        }
    }
}

#Preview {
    let container = try! ModelContainer(for: ContemplationHistory.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
    for _ in 0...20 {
        let contemplation = ContemplationHistory(technique: .meditation, startTime: Date(), endTime: Date().addingTimeInterval(100))
        container.mainContext.insert(contemplation)
    }
    return ContemplationsHistoryView().modelContainer(container)
}
