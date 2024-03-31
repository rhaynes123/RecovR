//
//  LogContemplationView.swift
//  RecovR
//
//  Created by richard Haynes on 3/31/24.
//

import SwiftUI

struct LogContemplationView : View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var startTime : Date = Date()
    @State private var endTime : Date = Date()
    
    var contemplation : Contemplation
    init(contemplation: Contemplation) {
        self.contemplation = contemplation
    }
    private func log(entry: ContemplationHistory){
        modelContext.insert(entry)
    }
    var body: some View {
        VStack {
            Form {
                Text("Name: \(contemplation.technique.rawValue)")
                Text("Contemplation Time at \(contemplation.timestamp, format: Date.FormatStyle( time: .standard))")
                
                DatePicker("Start Time", selection: $startTime)
                DatePicker("End Time", selection: $endTime)
                Button("Log"){
                    let entry = ContemplationHistory(technique: contemplation.technique, startTime: startTime, endTime: endTime)
                    log(entry: entry)
                    dismiss()
                }
            }
        }
    }
    
}

#Preview {
    let contemplation = Contemplation(timestamp: Date(), category: .contemplation, technique: .meditation)
    return LogContemplationView(contemplation: contemplation)
}
