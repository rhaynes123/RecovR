//
//  LogMedicationView.swift
//  RecovR
//
//  Created by richard Haynes on 3/31/24.
//

import SwiftUI
import SwiftData
struct LogMedicationView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @State private var actualTime : Date = Date()
    
    var medication : Medication
    
    init(medication: Medication) {
        self.medication = medication
    }
    private func log(entry: MedicationHistory){
        modelContext.insert(entry)
    }
    var body: some View {
        VStack {
            Form {
                Text("Name: \(medication.title)")
                Text("Dosage: \(medication.dose)  \(medication.administration.rawValue)(s)")
                Text("Dosage Time at \(medication.timestamp, format: Date.FormatStyle( time: .standard))")
                
                DatePicker("Actual Time", selection: $actualTime)
                Button("Log"){
                    let entry = MedicationHistory(administration: medication.administration, startTime: actualTime, dose: medication.dose, title: medication.title)
                    log(entry: entry)
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    let medication = Medication(timestamp: Date(), administration: .injection, title: "Asprin", category: .medication, dose: 2)
    return LogMedicationView(medication: medication)
}
