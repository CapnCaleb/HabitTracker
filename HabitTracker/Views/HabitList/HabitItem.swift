//
//  HabitItem.swift
//  HabitTracker
//
//  Created by Caleb on 12/21/24.
//


import SwiftUI

struct HabitItem: View {
    let habit: Habit
    var body: some View {
        VStack(alignment: .leading) {
            Text(habit.name)
                .font(.headline)
            Text(habit.habitDescription)
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
    }
}

#Preview(body: { 
    HabitItem(habit: Habit(name: "Placeholder Title", habitDescription: "Here is what this habit means"))
})
