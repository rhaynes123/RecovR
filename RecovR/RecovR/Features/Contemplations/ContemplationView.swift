//
//  ContemplationView.swift
//  RecovR
//
//  Created by richard Haynes on 3/28/24.
//

import SwiftUI
import SwiftData
struct ContemplationView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var contemplations: [Contemplation]
    @State private var showSheet: Bool = false
    
    
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(contemplations[index])
            }
        }
    }
    
    var body: some View {
        List {
            ForEach(contemplations) { item in
                NavigationLink("\(item.technique.rawValue) \(item.timestamp, format: Date.FormatStyle(time: .standard))", destination: LogContemplationView(contemplation: item))
            }
            .onDelete(perform: deleteItems)
           
        }.sheet(isPresented: $showSheet) {
            contemplationSheet()
        }
        Button(action : {
            showSheet.toggle()
        }) {
            Label("Add New \(Category.contemplation.rawValue)", systemImage: "figure.mind.and.body")
        }.frame(width: 300, height: 50, alignment: .center)
            .background(Color.blue)
            .foregroundColor(Color.black)
            .cornerRadius(10)
    }
}

struct contemplationSheet: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var modelContext
    @State var technique : Technique = .meditation
    @State var time : Date = Date()
    private func addItem(newItem : Contemplation) {
        withAnimation {
            modelContext.insert(newItem)
        }
    }
    var body: some View { 
        NavigationStack {
            Form {
                Picker("Technique", selection: $technique){
                    ForEach(Technique.allCases, id: \.self) {technique in
                        Text(technique.rawValue)
                        
                    }
                }
                DatePicker("Time", selection: $time, displayedComponents: .hourAndMinute)
                
            }.toolbar {
                ToolbarItemGroup(placement: .topBarLeading) {
                    Button("Cancel") {dismiss()}
                }
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button("Save") {
                        let newItem = Contemplation(timestamp: Date(), category: .contemplation, technique: technique)
                        addItem(newItem: newItem)
                        dismiss()
                    }
                }
            }
        }
    }
}



#Preview {
    ContemplationView()
        .modelContainer(for: Contemplation.self, inMemory: true)
}
