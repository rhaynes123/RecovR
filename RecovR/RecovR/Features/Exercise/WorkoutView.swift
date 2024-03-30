//
//  ExercisesView.swift
//  RecovR
//
//  Created by richard Haynes on 3/26/24.
//

import SwiftUI
import SwiftData
struct WorkoutView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var exercises: [Workout]
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
                modelContext.delete(exercises[index])
            }
        }
    }
    private func workoutSheet() -> some View {
        @State var exercise : Exercise = .pushUp
        return NavigationStack {
            Form {
                Picker("Exercise", selection: $exercise){
                    ForEach(Exercise.allCases, id: \.self) {technique in
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
            ForEach(exercises) { item in
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
                Label("Add New \(Category.exercise.rawValue)", systemImage: "figure.run")
            }
            .frame(width: 300, height: 50, alignment: .center)
                .background(Color.green)
                .foregroundColor(Color.black)
                .cornerRadius(10)
        }.sheet(isPresented: $showSheet){
            workoutSheet()
        }
        
    }
    
}

#Preview {
    WorkoutView().modelContainer(for: Workout.self, inMemory: true)
}
