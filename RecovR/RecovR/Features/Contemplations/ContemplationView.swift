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
    
    private func addItem() {
        withAnimation {
            //let newItem = Activity(timestamp: Date())
            //modelContext.insert(newItem)
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(contemplations[index])
            }
        }
    }
    private func contemplationSheet() -> some View {
        @State var technique : Technique = .meditation
        return NavigationStack {
            Form {
                Picker("Technique", selection: $technique){
                    ForEach(Technique.allCases, id: \.self) {technique in
                        Text(technique.rawValue)
                        
                    }
                }
               
            }.toolbar {
                ToolbarItemGroup(placement: .topBarLeading) {
                    Button("Cancel") {showSheet.toggle()}
                }
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button("Save") {
                        addItem()
                        showSheet.toggle()
                    }
                }
            }
        }
    }
    
    var body: some View {
        VStack {
            ForEach(contemplations) { item in
                NavigationLink {
                    Text("Item at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
                } label: {
                    Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
                }
            }
            .onDelete(perform: deleteItems)
            Button(action : {
                showSheet.toggle()
            }) {
                Label("Add New \(Category.contemplation.rawValue)", systemImage: "figure.mind.and.body")
            }.frame(width: 300, height: 50, alignment: .center)
                .background(Color.blue)
                .foregroundColor(Color.black)
                .cornerRadius(10)
        }.sheet(isPresented: $showSheet) {
            contemplationSheet()
        }
    }
}

#Preview {
    ContemplationView()
        .modelContainer(for: Contemplation.self, inMemory: true)
}
