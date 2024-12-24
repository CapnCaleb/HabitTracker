//
//  HabitsList.swift
//  HabitTracker
//
//  Created by Caleb on 12/21/24.
//


import SwiftData
import SwiftUI

struct HabitsList: View {
    @Query(sort: \Habit.created, order: .forward) var allHabits: [Habit]
    
    var body: some View {
        List {
            ForEach(allHabits) {
                HabitItem(habit: $0)
            }
        }
        .listStyle(.plain)
        .navigationTitle("Habits")
        .toolbar {
            ToolbarItem { 
                Button(action: {
                    
                }, label: {
                    Label("New Habit", systemImage: "plus")
                })
            }
        }
    }
}

#Preview(body: { 
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Habit.self, configurations: config)
    for i in 1..<10 {
        let habit = Habit(name: "Test \(i)", habitDescription: "Description for what \(i) is.")
        container.mainContext.insert(habit)
    }
    return NavigationStack {
        HabitsList()
            .modelContainer(container)
    }
})
