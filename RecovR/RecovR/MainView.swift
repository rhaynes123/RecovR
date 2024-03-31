//
//  ContentView.swift
//  RecovR
//
//  Created by richard Haynes on 3/25/24.
//

import SwiftUI
import SwiftData

struct MainView: View {
    var body: some View {
        NavigationSplitView {
            Form {
                
                Text("My Activities and Trends").font(.title)
                NavigationLink(destination: WorkoutHistoryView()){
                    Label("\(Category.exercise.rawValue) Trends", systemImage: "figure.run")
                }
                NavigationLink(destination: MedicationHistoryView()){
                    Label("\(Category.medication.rawValue) Trends", systemImage: "pills.circle")
                }
                NavigationLink(destination: ContemplationsHistoryView()){
                    Label("\(Category.contemplation.rawValue) Trends", systemImage: "figure.mind.and.body")
                }
                ForEach(Category.allCases, id: \.rawValue) { cat in
                    Section {
                        List {
                            switch cat {
                            case .exercise:
                                WorkoutView()
                            case .medication:
                                MedicationsView()
                            case .contemplation:
                                ContemplationView()
                            }
                        }
                    } header: {
                        Text(cat.rawValue)
                    }
                }
            }
        } detail: {
            Text("Select an activity")
        }
    }

   
}

#Preview {
    MainView()
}
