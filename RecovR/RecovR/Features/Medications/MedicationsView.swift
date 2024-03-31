//
//  MedicationsView.swift
//  RecovR
//
//  Created by richard Haynes on 3/26/24.
//

import SwiftUI
import SwiftData
struct MedicationsView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var medications: [Medication]
    @State private var showSheet: Bool = false
    
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(medications[index])
            }
        }
    }
    
    
    var body: some View {
        List {
            ForEach(medications) { item in
                NavigationLink("\(item.title) \(item.timestamp, format: Date.FormatStyle(time: .standard))", destination: LogMedicationView(medication: item))
            }
            .onDelete(perform: deleteItems)
        }.sheet(isPresented: $showSheet) {
            medicationSheet()
        }
        
        Button(action : {
            showSheet.toggle()
        }) {
            Label("Add New \(Category.medication.rawValue)", systemImage: "pills.circle")
        }.frame(width: 300, height: 50, alignment: .center)
            .background(Color.yellow)
            .foregroundColor(Color.black)
            .cornerRadius(10)
    }
}

struct medicationSheet : View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var modelContext
    @State var dosage : Int = 0
    @State var title : String = ""
    @State var adminstration : Adminstration = .pill
    @State var time : Date = Date()
    private func addItem(newItem : Medication) {
        withAnimation {
            if newItem.title.isEmpty {
                print("Title is required")
                return
            }
            modelContext.insert(newItem)
        }
    }
    
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Medication Name", text: $title)
                }
                
                Picker("Choose Administration", selection: $adminstration){
                    ForEach(Adminstration.allCases, id: \.self) {admin in
                        Text(admin.rawValue)
                        
                    }
                }
                
                Section {
                    TextField("Dose", value: $dosage, format: .number)
                } header: {
                    Text("Dosage")
                }
                DatePicker("Time", selection: $time, displayedComponents: .hourAndMinute)
                
            }
            .toolbar {
                ToolbarItemGroup(placement: .topBarLeading) {
                    Button("Cancel") {dismiss()}
                }
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button("Save") {
                        let medication = Medication(timestamp: time, administration: adminstration, title: title, category: .medication, dose: dosage)
                        addItem(newItem: medication)
                        dismiss()
                    }
                }
            }
        }
    }
}



#Preview {
    let container = try! ModelContainer(for: Medication.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
    container.mainContext.insert(Medication(timestamp: Date(), administration: .pill, title: "Asprin", category: .medication, dose: 2))
    return MedicationsView().modelContainer(container)
}
