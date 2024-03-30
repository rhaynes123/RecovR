//
//  ContentView.swift
//  RecovR
//
//  Created by richard Haynes on 3/25/24.
//

import SwiftUI
import SwiftData

struct MainView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var exercises: [Workout]
    @State private var displayAlert : Bool = false
    var body: some View {
        NavigationSplitView {
            Form {
                
                Text("My Activities").font(.title)
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
